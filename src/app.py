import os
import psycopg2
# import mysql.connector
from components import model, transform, infer
import pandas as pd

from flask import Flask, render_template, redirect, url_for, request
# from sqlalchemy import create_engine

app = Flask(__name__)

app.template_folder = os.path.join('..', 'templates')

zero_shot = model.load_zero_shot_model()
emb_model = model.load_emb_model()

df = pd.read_csv(os.path.join("..","knowledge_base", "lmd_knowledge.csv"))
data = transform.extract(df, desc="question", message="answer")
corpus_embeddings = transform.embed_corpus(emb_model, data)

def get_db_connection():
    conn = psycopg2.connect(
        user="postgres",  # Replace with your PostgreSQL username
        host="localhost",
        database="lmd_db",  # Replace with your database name
        port="5432",
    )

    # conn = mysql.connector.connect(
    #     host="localhost",
    #     user="root",
    #     password="",
    #     database='lmd_db',
    #     port = 3306
    # )

    print("Connection to database succesfull!")
    return conn


@app.route('/chatbot', methods=['POST'])
def chatbot():
    if request.method == 'POST':
        if request.form["query"] == "":
            return {"output" : "Please insert a question"}
        # if request.form["th"] == "":
        #     th = 0
        query = request.form["query"]
        th = float(request.form["th"])
        u_th = float(request.form["u_th"])
        t_th = float(request.form["t_th"])

        q_score, doc_id = infer.infer_emb(emb_model, corpus_embeddings, question=query, threshold=th)

        if q_score >= th:
            return {"output" : data[doc_id][-1], "q_score":float(q_score)}

        conn = get_db_connection()
        cur = conn.cursor()
        # print("OK")
        # cur.execute('SELECT customer_id from customers;')
        cur.execute('SELECT user_id from users;')
        # cust_ids = [f"customer_id = {x[0]}" for x in cur.fetchall()]
        cust_ids = [f"user_id = {x[0]}" for x in cur.fetchall()]
        
        cust_id = zero_shot(query, candidate_labels=cust_ids)

        if float(cust_id['scores'][0]) < u_th:
            return {
                "response": "Anda tidak memasukkan User ID atau User ID anda tidak terdaftar. Mohon masukkan User ID yang terdaftar",
                "query":query, 
                "q_score" : float(q_score),
                "top_user_id" : int(cust_id['labels'][0][-2:].strip()),
                "user_id_score" : float(cust_id['scores'][0])
            }

        cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
        candidate_labels = [str(x[0]) for x in cur.fetchall() if x[0] not in 'users']
        print(candidate_labels)
        tag = zero_shot(query, candidate_labels=candidate_labels)#['servers','products', 'sales'])

        if float(tag['scores'][0]) < t_th:
            return {
                "response": "Permintaan tidak terdeteksi, [membuat tiket baru]... Mohon tunggu sebentar, Customer Service akan membantumu",
                "query":query, 
                "q_score" : float(q_score),
                "top_user_id" : tag['labels'][0],
                "tag_score" : float(tag['scores'][0])
            }

        cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{tag['labels'][0]}';")
        col_names = [str(x[0]) for x in cur.fetchall()]

        # return redirect(url_for('pred'), cust_id=cust_id, tag=tag)
        print(tag, cust_id)
        # cur.execute(f'SELECT * from {tag} where customer_id = {cust_id[-1]};')
        cur.execute(f"SELECT * from {tag['labels'][0]} where user_id = {int(cust_id['labels'][0][-2:].strip())};")
        # cur.execute("SELECT * from %s WHERE customer_id=%s", (tag, cust_id))
        results = transform.decimal_to_float(cur.fetchall())
        cur.close()
        conn.close()

        out = [{col_name : v for col_name,v in zip(col_names,res)} for res in results]
        return {
            "output":out, 
            "tag_score" : float(tag['scores'][0]), "user_id_score" : float(cust_id['scores'][0]), 
            "q_score" : float(q_score)
        }
        


@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)



