import pandas as pd 

def extract(df, desc, message):
    
    return [
        [f'Represent the document for retrieval of {x[desc]} information : ',
        x[message]] 
        for _,x in df.iterrows()
    ]

def embed_corpus(emb_model, data):
    return emb_model.encode(data)