FROM python:3.11-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -e .

EXPOSE 5000

CMD ["flask", "--app", "flaskr", "run", "--host=0.0.0.0"]
