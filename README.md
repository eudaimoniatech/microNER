# microNER

A micro-service for Named Entity Recognition based on Docker.

We provide four pre-trained models for German.

All details: https://uhh-lt.github.io/microNER

# Build and run

The image needs a dataset from fasttext.cc. Download the following https://dl.fbaipublicfiles.com/fasttext/vectors-wiki/wiki.de.zip and unzip it in embeddings/.
Now run:

	docker build . -t microNER
	docker run -v $(pwd)/embeddings:/app/embeddings:Z -p 5001:5001 microNER

# Export to Tensorflow protobuf
We managed to export the models with specific versions of python, tensorflow and keras. To install them you need Miniconda3.
To export this model as a TensorFlow protobuf run:

	conda env create -f=conversionenv.yml
	conda activate microNERattempt1
	git submodule init
	git submodule update
	python export_models.py
	python convert_models.py

The converted models are now in `converted_models`.
