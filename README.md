# Lintas Media Danawa (LMD) ChatBot
### Inputs
1. Query : user input / questions
2. Query Threshold : minimum similarity score (accuracy) for the model to retrieve the information from static knowledge base. Ranges from 0 to 1
3. User ID Threshold : minimum similarity score (accuracy) for the model to check the availability of user id in the user input. Ranges from 0 to 1
4. Tags Threshold : minimum similarity score (accuracy) for the model to understand which database's table to retrieve for the user requests. Ranges from 0 to 1

### Outputs
Json format consists of at least the chatbot response and the similarity scores

## How it works
There are two models to build the chatbot : Zero-Shot Classfication and Instructor Embedding models<br>

Below are the flowcharts of the model's inference pipeline :
![alt text](media/flowchart1.png)
<br>
Flowchart of "check database" process of the above flowchart :
![alt text](media/check_database.png)
<br>
Flowchart of "create new ticket" process of the above flowchart : 
![alt_text](media/create_new_ticket.png)

## Database 
PostgreSQL, consists of 4 tables : 
1. users : user personal information 
   - columns : user_id, first_name, last_name, email, phone_number, address, registration_date
2. products : products owned by the users
   - columns : product_id, product_name, price
3. sales : sales of the products for each users
   - columns : sale_id, user_id, product_id, sale_date, quantity, total_price
4. servers : servers owned by the users
   - columns : server_id, location, status, user_id

## Run App
Clone the github
```bash
git clone https://github.com/Jonathanjordan21/lmd_chatbot.git
```

Create a virtual environment
```bash
python -m venv env
```

Activate the virtual environment
```bash
env\Scripts\activate
```

Install the requirements
```bash
pip install -r requirements.txt
```

Start the flask app
```bash
cd src
```
```bash
flask run
```

