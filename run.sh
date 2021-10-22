#/temp/spark/spark-3.1.2-bin-hadoop3.2/bin/spark-sql&
SPARK_HOME=/temp/spark/spark-3.1.2-bin-hadoop3.2
#echo 'while(true){Thread.sleep(1000);}' | $SPARK_HOME/bin/spark-shell&
$SPARK_HOME/sbin/start-all.sh

PORT=8085
exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 hello:app
