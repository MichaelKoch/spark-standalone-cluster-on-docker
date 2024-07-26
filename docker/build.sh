docker build ./spark-dependendies -f ./spark-dependendies/Dockerfile -t spark-dependendies
docker build ./spark-base -f ./spark-base/Dockerfile -t spark-base
docker build ./spark-worker -f ./spark-worker/Dockerfile -t spark-worker
docker build ./spark-master -f ./spark-master/Dockerfile -t spark-master
docker build ./jupyterlab -f ./jupyterlab/Dockerfile -t jupyterlab