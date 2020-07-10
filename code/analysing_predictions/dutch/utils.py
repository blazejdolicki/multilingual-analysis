import pandas as pd
import numpy as np
'''
    Read data for tag classification tasks used in XTREME. This method returns a dataset where each row contains one sentence and its ground truth tags.
'''

class PredictionsAnalyzer():
    

    def __init__(self):
        self.all_sentences = []
        self.all_tags = []
        self.all_pred_tags = []
        self.unique_tags = "ADJ ADP ADV AUX CCONJ DET INTJ NOUN NUM PART PRON PROPN PUNCT SCONJ SYM VERB X".split()
        # using total_tags as private object variables is kind of hacky, would be better to return them from transform_data()
        # TODO: to avoid returning many variables from this method, maybe we could return a dictionary with those variables instead
        self.total_tags = 0
        self.true_tags = 0

    def read_tag_data(self, actuals_fname, pred_fname=None):
        with open(actuals_fname,encoding="utf-8") as f:
            lines = f.read().split("\n")

        sentence = ""
        sentene_tags = ""
        i = 0
        for line in lines:
        #     if a sentence ended
            if line=="":
                i += 1
                self.all_sentences.append(sentence.strip())
                self.all_tags.append(sentene_tags.strip())
                sentence =""
                sentene_tags = ""
            else:
                word = line.split("\t")[0]
                tag = line.split("\t")[1]

                sentence += " "+word
                sentene_tags += " "+tag

        # if a file with predictions is included
        if pred_fname is not None:
            with open(pred_fname,encoding="utf-8") as f:
                lines = f.read().split("\n")

            pred_tags = ""
            for line in lines:
            #     if a sentence ended
                if line=="":
                    self.all_pred_tags.append(pred_tags.strip())
                    pred_tags = ""
                else:
                    pred_tags += " "+line

            df = pd.DataFrame(data={"sentences":self.all_sentences,"ground_truth":self.all_tags,"predictions":self.all_pred_tags})
        else:
            df = pd.DataFrame(data={"sentences":self.all_sentences,"ground_truth":self.all_tags})
        
        return df

    '''
        Trasnform data to get a df with tokens that satisfy a specified condition.
        If conf_matrix=False, the confusion matrix that is returned as the second output is empty. The conf_matrix should be only true
        when the condition is checking if the predictions are correct.
    '''

    def transform_data(self, condition, conf_matrix=False):


        self.total_tags = 0
    #     tags satisfying the condition
        self.true_tags = 0

        confusion_matrix = np.zeros((len(self.unique_tags),len(self.unique_tags)))


        if self.are_preds_loaded():  
            mistakes_df = {"predicted":[], "actual":[],"token":[],"sentence":[],"actual_tokens":[]}
        else:
            mistakes_df = {"actual":[],"token":[],"sentence":[],"actual_tokens":[]}
            print("Warning: Predictions are not loaded, if your condition contains a prediction, your output will be incorrect")


        for i in range(len(self.all_tags)):
            actual_sent = self.all_tags[i].split()
            if self.are_preds_loaded():
                pred_sent = self.all_pred_tags[i].split()
            for j in range(len(actual_sent)):
                actual_tag = actual_sent[j]

                if self.are_preds_loaded():
                    pred_tag = pred_sent[j]
                else:
                    pred_tag = None
                
                if condition(actual_tag, pred_tag):
                    if self.are_preds_loaded():
                        mistakes_df["predicted"].append(pred_tag)
                    mistakes_df["actual"].append(actual_tag)
                    mistakes_df["token"].append(self.all_sentences[i].split()[j])
                    mistakes_df["sentence"].append(self.all_sentences[i])
                    mistakes_df["actual_tokens"].append(" ".join(actual_sent))

                    # if predictions are not loaded
                    if conf_matrix:
                        assert self.are_preds_loaded, "Cannot create a confusion matrix because predictions are not loaded." \
                        "Run read_tag_data() with filenames of actuals and predictions and then rerun this command."
                        confusion_matrix[self.unique_tags.index(pred_tag)][self.unique_tags.index(actual_tag)] += 1
                    self.true_tags += 1
                self.total_tags += 1

        mistakes_df = pd.DataFrame.from_dict(mistakes_df)
        conf_df = pd.DataFrame(data=confusion_matrix,index=self.unique_tags,columns=self.unique_tags)
        return mistakes_df, conf_df
    
    

    def are_preds_loaded(self):
        return len(self.all_pred_tags)>0
            
