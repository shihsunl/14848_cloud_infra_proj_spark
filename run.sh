/temp/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-sql&
PORT=8080
exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 hello:app
