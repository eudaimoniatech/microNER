FROM ubuntu:18.04 AS environment

RUN apt-get update && apt-get install -y \
    locales \
    software-properties-common \
    python3.6 \ 
    python3.6-dev 
    # \
    # && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

FROM environment AS application

WORKDIR /app/
EXPOSE 5001

RUN apt-get install -y \
    git-core \ 
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pybind11
ADD requirements.txt .
RUN --mount=type=cache,target=/root/.cache \
    pip3 install -r requirements.txt
ADD scripts/*.py scripts/
RUN pip3 install git+https://www.github.com/keras-team/keras-contrib.git

# COPY embeddings/ embeddings/
COPY models/ models/
COPY templates/ templates/

ADD app.py .
RUN mkdir -p embeddings
RUN chmod 777 -R embeddings

ENV TF_CPP_MIN_LOG_LEVEL=2
ENV FLASK_APP app.py
ENV FLASK_DEBUG 1

CMD flask run --host 0.0.0.0 --port 5001
# Commented lines doesnt work on WIN10
# CMD flask run --host 0.0.0.0 --port 5001 --with-threads
# CMD gunicorn -b 0.0.0.0:5001 --log-level info --worker-connections 1000 --timeout 0 app:app
# CMD gunicorn -b 0.0.0.0:5001 --log-level debug --worker-class gevent --worker-connections 1000 --timeout 0 app:app