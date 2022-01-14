## Place fastText models from fasttext.cc here

You can download the language specific pretrained vectors from the official Facebook fastText repository 

https://fasttext.cc/docs/en/pretrained-vectors.html

or directly the default one from here https://dl.fbaipublicfiles.com/fasttext/vectors-wiki/wiki.de.zip

Please note that the file is pretty big and can cause docker container execution issues if the docker container  has not access to at least 10GB 

```sh
docker run -p 5001:5001 --memory="8g" --memory-swap="10g" eudaimoniatech/microner:v3.1.2
```

