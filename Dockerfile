# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

ENV FLASK_APP=/app/src/app.py

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir torch==2.1.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install --no-cache-dir -r requirements.txt

# Run app.py when the container launches
CMD ["python", "./src/app.py"]