# Since we were unable to reproduce the build of this Dockerfile, we had to export the models from the docker image uhhlt/microner:v0.1 on docker hub.
import tensorflow as tf
import scripts.ner as ner

def export_model(filename):
    folder = "exported_models/"
    n = ner.NerModel(filename)
    n.model.save(folder+filename)

    mjson = n.model.to_json()
    f = open(folder+filename+".json", "w")
    f.write(mjson)
    f.close()

export_model("conll.h5")
export_model("germeval-conll.h5")
export_model("germeval.h5")
export_model("germeval-inner.h5")

