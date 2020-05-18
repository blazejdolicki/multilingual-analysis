langs="af ar bg de el en es et eu fa fi fr he hi hu id it"

key_dir="C:/Users/bdolicki/.ssh/blazej-key-pair.pem"
user="ubuntu"
vm_ip="ec2-3-121-200-176.eu-central-1.compute.amazonaws.com"
vm_dir="/home/ubuntu/xtreme/outputs-temp/udpos"
local_dir="C:/Users/bdolicki/Documents/Git/multilingual-analysis/code/analysing_features/udpos/results"

for lang in $langs; do
    scp -i ${key_dir} ${user}@${vm_ip}:${vm_dir}/xlm-roberta-base-LR2e-5-epoch-MaxLen128-train-${lang}/dev_results.txt $local_dir/dev_results_${lang}.txt
done