import scripts.ner as ner

def export_model(filename):
    n = ner.NerModel(filename)
    n.model.save("exported_models/"+filename)

export_model("conll.h5")
export_model("conll.indexes")
export_model("germeval-conll.h5")
export_model("germeval-conll.indexes")
export_model("germeval.h5")
export_model("germeval.indexes")
export_model("germeval-inner.h5")
export_model("germeval-inner.indexes")
