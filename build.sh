#!/bin/bash
export TF_CPP_MIN_LOG_LEVEL=2
docker build --target application -f Dockerfile -t eudaimoniatech/microner:v1.1.0 --progress=plain .
docker build -f Dockerfile -t eudaimoniatech/microner:v1.1.0 --progress=plain .
# docker run -p 5001:5001 --volume=${PWD}/embeddings:/app/embeddings --memory="6g" --memory-swap="8g" eudaimoniatech/microner:v1.1.0
# docker run -rm -it -p 5001:5001 --volume=${PWD}/embeddings:/app --memory="6g" --memory-swap="8g" eudaimoniatech/microner:v1.1.0 /bin/sh
# docker run -rm -it -p 5001:5001 --volume=${PWD}/embeddings:/app --memory="6g" --memory-swap="8g" eudaimoniatech/microner:v1.1.0
