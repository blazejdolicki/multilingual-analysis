# Analysing The Impact Of Linguistic Features On Cross-Lingual Transfer
## Introduction
This repository presents work that I have done for my bachelor thesis "Analysing The Impact Of Linguistic Features On Cross-Lingual Transfer" which was prepared in partial fulfilment of the requirements for the Degree of Bachelor of Science in Data Science and Knowledge Engineering, Maastricht University. The paper is available here: https://arxiv.org/pdf/2105.05975

## Data
We used the following datasets in our analysis: 
* 110k Dutch Book Reviews Dataset for Sentiment Analysis [1]
* Webis Cross-Lingual Sentiment Dataset 2010 (unprocessed) [2]
* Universal Dependencies 2.2 [3]
* Wikiann NER [4]
* XNLI [5]   

## Benchmarking zero-shot learning for Dutch
We tested 3 recent models on zero-shot and supervised learning in Dutch: LASER [6], Multifit [7] and XLM-R [8]. The results are shown in the table below. We used accuracy and f1 score for CLS+ and UD POS respectively.

| Models      | CLS+        | UD POS |
| ----------- | ----------- | ----------- 
| **Zero-shot learning (train on English, test on Dutch)** |
| LASER      | 77.65       ||
| Multifit, QRNN   | 78.55        ||
| Multifit, transformer      | 79.70       ||
| XLM-R   | 88.95        |0.9023 |
| **Supervised learning (train on Dutch, test on Dutch)** |
| LASER      | 82.45       ||
| Multifit, QRNN   | 90.30        ||
| Multifit, transformer      | 89.75       ||
| XLM-R   | 92.00        | 0.9781 ||

Logs with the results are attached in the `results` folder. Every folder is named according to the following convention `<lanuage> <model name> <dataset> <"supervised" or "zero-shot"> <additional remarks> <optionally: gpu instance used for training>`

To reproduce the experiments use the repositories below. Each repository has instructions to run particular experiments in README.
* LASER: https://github.com/blazejdolicki/LASER
* Multifit: https://github.com/blazejdolicki/multifit
* XLM-R: https://github.com/blazejdolicki/xtreme

## Linguistic analysis
In the second part we analysed how linguistic features influence the performance in zero-shot learning. The scripts I used are in the `code` folder which in turn contains two important folders: `analysing_features` and `analysing_predictions`. 
In the former we analyse how important particular features are for transfer performance, the main notebook for each task is "Feature importance <task>.ipynb". In the latter we examine model outputs and look for patterns in zero-shot predictions. We take an especially close look at Dutch and more of a general overview of other languages. Using the `utils.py` it is easy to examine the outputs of sequence tagging tasks with just a few lines of code. We hope that by publishing the predictions for many languages we encourage researchers to further examine the predictions in order to gain further insights.
  
The results and predictions for all languages are available here: https://drive.google.com/file/d/1Lf5eFS2KRqnJbY7L7oH6agz0DnVgcDsT/view?usp=sharing
After unzipping this foler, you should put the folder 'results' from 'predictions and results/<task>/' into 'multilingual-analysis\code\analysing_features\<task>' and folders 'dev_sets' and 'results' from 'predictions and results/<task>/predictions/' into 'multilingual-analysis\code\analysing_predictions\<task>'.
 

## References
[1] B. van der Burgh and S. Verberne, “The merits of universal language
model fine-tuning for small datasets–a case with dutch book reviews,”
arXiv preprint arXiv:1910.00896, 2019.

[2] P. Prettenhofer and B. Stein, “Cross-language text classification using
structural correspondence learning,” in Proceedings of the 48th annual
meeting of the association for computational linguistics, Conference
Proceedings, pp. 1118–1127.

[3] J. Nivre, M. Abrams, Agic, L. Ahrenberg, L. Antonsen, M. J. Aranzabe, ´
G. Arutie, M. Asahara, L. Ateyah, and M. Attia, “Universal dependencies 2.2,” 2018

[4] X. Pan, B. Zhang, J. May, J. Nothman, K. Knight, and H. Ji, “Crosslingual name tagging and linking for 282 languages,” in Proceedings
of the 55th Annual Meeting of the Association for Computational
Linguistics (Volume 1: Long Papers). Vancouver, Canada: Association
for Computational Linguistics, Jul. 2017, pp. 1946–1958. [Online].
Available: https://www.aclweb.org/anthology/P17-1178

[5] ] A. Conneau, G. Lample, R. Rinott, A. Williams, S. R. Bowman,
H. Schwenk, and V. Stoyanov, “XNLI: evaluating cross-lingual sentence
representations,” CoRR, vol. abs/1809.05053, 2018. [Online]. Available:
http://arxiv.org/abs/1809.05053

[6] M. Artetxe and H. Schwenk, “Massively multilingual sentence embeddings for zero-shot cross-lingual transfer and beyond,” Transactions of
the Association for Computational Linguistics, vol. 7, pp. 597–610, 2019.

[7] J. Eisenschlos, S. Ruder, P. Czapla, M. Kardas, S. Gugger, and
J. Howard, “Multifit: Efficient multi-lingual language model finetuning,” arXiv preprint arXiv:1909.04761, 2019.

[8] A. Conneau, K. Khandelwal, N. Goyal, V. Chaudhary, G. Wenzek, F. Guzman, E. Grave, M. Ott, L. Zettlemoyer, and V. Stoyanov, “Unsupervised cross-lingual representation learning at scale,” arXiv preprint arXiv:1911.02116, 2019.
