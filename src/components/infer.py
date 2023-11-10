from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

def infer_emb(model, corpus_embeddings, question, threshold):
    query  = [['Represent the question for retrieving supporting documents: ',question]]
    query_embeddings = model.encode(query)
    similarities = np.squeeze(cosine_similarity(query_embeddings,corpus_embeddings))
    retrieved_doc_id = np.argmax(similarities)

    return similarities[retrieved_doc_id], retrieved_doc_id
