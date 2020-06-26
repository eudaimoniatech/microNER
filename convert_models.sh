#!/bin/sh

for model in conll germeval-conll germeval germeval-inner
do
    python keras_to_tensorflow/keras_to_tensorflow.py \
        --input_model="exported_models/${model}.h5" \
        --input_model_json="exported_models/${model}.h5.json" \
        --output_model="converted_models/${model}.pb"
done
