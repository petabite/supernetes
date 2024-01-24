FROM python:3.11
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
ENTRYPOINT gunicorn -b 0.0.0.0:5000 app:app
