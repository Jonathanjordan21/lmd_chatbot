import os
import psycopg2
# import mysql.connector
from components import model, transform, infer
import pandas as pd


from flask import Flask, render_template, redirect, url_for, request
# from sqlalchemy import create_engine

app = Flask(__name__)
zero_shot = model.load_zero_shot_model()
emb_model = model.load_emb_model()

df = pd.read_csv(os.path.join("knowledge_base", "lmd_knowledge.csv"))
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
    return conn


@app.route('/chatbot', methods=['POST'])
def chatbot():
    if request.method == 'POST':
        if request.form["query"] == "":
            return {"output" : "Please insert a question"}
        if request.form["th"] == "":
            th = 0
        query = request.form["query"]
        th = float(request.form["th"])

        q_score, doc_id = infer.infer_emb(emb_model, corpus_embeddings, question=query, threshold=th)

        if q_score >= th:
            return {"output" : data[doc_id][-1], "q_score":f"{q_score}"}

        conn = get_db_connection()
        cur = conn.cursor()
        # print("OK")
        # cur.execute('SELECT customer_id from customers;')
        cur.execute('SELECT user_id from users;')
        # cust_ids = [f"customer_id = {x[0]}" for x in cur.fetchall()]
        cust_ids = [f"user_id = {x[0]}" for x in cur.fetchall()]
        
        cust_id = zero_shot(query, candidate_labels=cust_ids)
        tag = zero_shot(query, candidate_labels=['servers','products', 'sales'])
        # return redirect(url_for('pred'), cust_id=cust_id, tag=tag)
        print(tag, cust_id)
        # cur.execute(f'SELECT * from {tag} where customer_id = {cust_id[-1]};')
        cur.execute(f"SELECT * from {tag['labels'][0]} where user_id = {int(cust_id['labels'][0][-2:].strip())};")
        # cur.execute("SELECT * from %s WHERE customer_id=%s", (tag, cust_id))
        return {"output":cur.fetchall(), "tag_score" : f"{tag['scores'][0]}", "user_id" : f"{cust_id['scores'][0]}", "q_score":f"{q_score}"}
        

# @app.route('/pred')
# def pred():
#     cust_id = request.args.get('cust_id')
#     tag = request.args.get('tag')
#     conn = get_db_connection()
#     cur = conn.cursor()
#     cur.execute(f'SELECT * from {tag} where customer_id = {cust_id};')
#     return {"output":cur.fetchall()}






@app.route('/')
def index():
    # conn = get_db_connection()
    # cur = conn.cursor()
    # cur.execute('SELECT customer_id from customers;')
    # books = [f"customer_id = x[0]" for x in cur.fetchall()]
    # print(books)
    # cur.close()
    # conn.close()
    # return f"""<h1>{books}</h1>"""
    
    return render_template('index.html')
    # create_engine('postgresql+psycopg2://user:password@hostname/database_name')
    # return {"book":"a"}


if __name__ == '__main__':
    app.run(debug=True)

# from fastapi import FastAPI
# import os
# import pandas as pd
# from components import embed
# import numpy as np
# from sklearn.metrics.pairwise import cosine_similarity
# from fastapi.responses import HTMLResponse
# from typing import Annotated
# # from fastapi.templating import Jinja2Templates
# from django.shortcuts import render
# from components import extract

# app = FastAPI()

# model = embed.load_emb_model()
# df = pd.read_csv('knowledge_base/intent.csv', delimiter=';')
# data = extract.extract(df, desc='description', message='message')

# corpus_embeddings = model.encode(data)

# # templates = Jinja2Templates(directory="templates")

# @app.get('/template')
# def show_template():
#     return df.to_html()

# @app.post('/chatbot/')
# def chatbot(query: Annotated[str, Form()]):
#     query  = [['Represent the question for retrieving supporting documents: ',query]]
#     query_embeddings = model.encode(query)
#     similarities = cosine_similarity(query_embeddings,corpus_embeddings)
#     retrieved_doc_id = np.argmax(similarities)
#     return {"response" : data[retrieved_doc_id][-1]}

# # @app.get('/'):
# # def root():


# # @app.get("/", response_class=HTMLResponse)
# # async def root():
# #     return templates.TemplateResponse("index.html", {})



# @app.get("/")
# def index (request):
#     return render(request, 'templates/index.html')


