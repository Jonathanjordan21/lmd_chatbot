from InstructorEmbedding import INSTRUCTOR
from tensorflow import data
from transformers import pipeline

def load_emb_model():
    return INSTRUCTOR('hkunlp/instructor-large')

def load_zero_shot_model():
    return pipeline(
        "zero-shot-classification", 
        model="MoritzLaurer/mDeBERTa-v3-base-xnli-multilingual-nli-2mil7",
        cache_dir="zero_shot_model"
    )
