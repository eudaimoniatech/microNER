
FROM alpine AS builder

RUN apk add curl
RUN curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > miniconda3.sh
RUN chmod +x miniconda3.sh

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y python3.7

COPY --from=builder miniconda3.sh .
RUN ./miniconda3.sh -b
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
SHELL ["/bin/bash", "-c"]
RUN conda init
RUN conda create -n microNER python=3.5
RUN echo "source activate microNER" > ~/.bashrc
ENV PATH /opt/conda/envs/microNER/bin:$PATH

RUN conda install -y numpy==1.15.1
RUN conda install -y keras==2.2.4
#RUN conda install -y tensorflow==1.12.1
RUN apt-get -y install git-core build-essential
RUN pip install git+git://github.com/facebookresearch/fastText@v0.2.0
# RUN pip3 install git+https://github.com/facebookresearch/fastText.git
RUN conda install -y scikit-learn==0.19.2
RUN conda install -y Flask==1.0.2
RUN pip install flask-bootstrap==3.3.7.1
RUN conda install -y jsonschema==2.6.0
RUN conda install -y gunicorn==19.9.0

#RUN apt-get update 
#RUN apt-get -y install software-properties-common
#RUN apt-get update
#
## set noninteractive installation
#RUN export DEBIAN_FRONTEND=noninteractive
##install tzdata package
#RUN apt-get install -y tzdata
## set your timezone
#RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
#RUN dpkg-reconfigure --frontend noninteractive tzdata
#
#RUN apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
##RUN apt-get clean && apt-get update && apt-get install -y locales
#
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    dpkg-reconfigure --frontend=noninteractive locales && \
#    update-locale LANG=en_US.UTF-8

RUN apt-get install -y locales
RUN locale-gen --purge en_US.UTF-8
RUN echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale

#RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

WORKDIR /app/
EXPOSE 5001

RUN apt-get -y install python3-pip
#RUN pip3 install pybind11

#ADD requirements.txt .
#RUN pip3 install -r requirements.txt

RUN pip3 install git+https://www.github.com/keras-team/keras-contrib.git
ADD scripts/*.py scripts/
ADD embeddings/wiki.de.bin embeddings/wiki.de.bin
COPY models/ models/
COPY templates/ templates/
ADD app.py .

ENV FLASK_APP app.py
ENV FLASK_DEBUG 0
# CMD flask run --host 0.0.0.0 --port 5001 --with-threads
CMD gunicorn -b 0.0.0.0:5001 --worker-connections 1000 --timeout 180 app:app
