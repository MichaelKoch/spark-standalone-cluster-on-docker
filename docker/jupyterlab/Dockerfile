FROM spark-dependendies

# -- Layer: Image Metadata

LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - JupyterLab Image"
LABEL org.label-schema.description="JupyterLab image"
LABEL org.label-schema.url="https://github.com/MichaelKoch/spark-standalone-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: JupyterLab + Python kernel for PySpark

ARG spark_version=4.0.0-preview1
ARG jupyterlab_version=4.2.4
ARG scala_kernel_version=0.13.14

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install wget==3.2  pyspark==4.0.0.dev1 jupyterlab==${jupyterlab_version}

# -- Layer: Scala kernel for Spark

ARG ARG scala_version=2.12.10

RUN apt-get install -y ca-certificates-java --no-install-recommends && \
    curl -Lo coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    ./coursier launch --fork almond:${scala_kernel_version} --scala ${scala_version} -- --display-name "Scala ${scala_version}" --install && \
    rm -f coursier

# -- Layer: R kernel for SparkR

RUN apt-get install -y r-base-dev && \
    R -e "install.packages('IRkernel')" && \
    R -e "IRkernel::installspec(displayname = 'R 3.5', user = FALSE)" && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/SparkR_${spark_version}.tar.gz -k -o sparkr.tar.gz && \
    R CMD INSTALL sparkr.tar.gz && \
    rm -f sparkr.tar.gz



# -- Runtime
# -- Layer: Notebooks and data
ADD workspace/ /opt/workspace/

EXPOSE 8888

WORKDIR ${SHARED_WORKSPACE}
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=
