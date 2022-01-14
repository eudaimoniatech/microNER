# microNER

A micro-service for Named Entity Recognition based on Docker.

We provide four pre-trained models for German.

All details: https://uhh-lt.github.io/microNER

# Export to Tensorflow protobuf
We managed to export the models with specific versions of python, tensorflow and keras. To install them you need Miniconda3.
To export this model as a TensorFlow protobuf run:

```sh
conda env create -f=conversionenv.yml
conda activate microNERattempt1
git submodule init
git submodule update
python export_models.py
python convert_models.py
```

The converted models are now in `converted_models`.

# Working version for Ubuntu 18.04 and WIN 10

We have cleaned up the dockerfile adopting multi-stage builds best practices and pip cache optimization
This version works both on Ubuntu 18.04 and Windows 10 with tensorflow 1.0.5 and facebook fastText 0.9.1
The embedding folder is empty because the **wiki.de.bin** is quiet big (7 GB) but you can download
it from here https://dl.fbaipublicfiles.com/fasttext/vectors-wiki/wiki.de.zip

Before starting check if your CPU supports AVX by using one of the following ways on Linux because TensorFlow will not work without it

```shell
sudo apt-get install inxi
inxi -F 
# OR 
cat /proc/cpuinfo
# OR
grep avx /proc/cpuinfo
```

On Windows 10 use [Coreinfo - Windows Sysinternals](https://docs.microsoft.com/en-us/sysinternals/downloads/coreinfo) that will show you if AVX is enabled
