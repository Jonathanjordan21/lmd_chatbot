import pandas as pd 
from decimal import Decimal
from collections.abc import Iterable

def extract(df, desc, message):
    
    return [
        [f'Represent the document for retrieval of {x[desc]} information : ',
        x[message]] 
        for _,x in df.iterrows()
    ]

def embed_corpus(emb_model, data):
    return emb_model.encode(data)

def decimal_to_float(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    elif isinstance(obj, Iterable):
        return [decimal_to_float(item) for item in obj]
    else :
        return obj
