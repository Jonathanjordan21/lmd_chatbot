import pandas as pd
import os
import re

with open(os.path.join("..", "knowledge_base", "message.txt"), "r") as f:
    data = f.read()


questions = re.findall(r'\n\* \*\*(.*?)\*\*', data)
answers = [x for x in re.split(r'\n\* \*\*(.*?)\*\*', data) if x not in questions][1:]

# for match in answers:
#     print(match)
# print(len(answers), len(questions))

df = pd.DataFrame({"question" : questions, "answer":answers})
# print(df)
df.to_csv(os.path.join("..", "knowledge_base", "lmd_knowledge.csv"))

