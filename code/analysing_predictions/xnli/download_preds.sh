langs="ar bg de el en es fr hi ru sw th tr ur vi zh"
# langs="en"
key_dir="C:/Users/bdolicki/.ssh/blazej-key-pair.pem"
user="ubuntu"
vm_ip="ec2-18-184-100-188.eu-central-1.compute.amazonaws.com"
preds_dir="/home/ubuntu/xtreme/outputs-temp/xnli"
data_dir="/home/ubuntu/xtreme/download/xnli"
local_dir="C:/Users/bdolicki/Documents/Git/multilingual-analysis/code/analysing_predictions/xnli"
folders="results dev_sets"

for folder in $folders; do
    if [ ! -d "${local_dir}/${folder}" ]; then
        mkdir ${local_dir}/${folder}
        echo "Created ${local_dir}/${folder}"
    fi
done

for lang1 in $langs; do
    for lang2 in $langs; do
        scp -i ${key_dir} ${user}@${vm_ip}:${preds_dir}/xlm-roberta-base-LR2e-5-epoch5-MaxLen128-train-${lang1}/dev-${lang2}-prediction.tsv $local_dir/results/dev_${lang1}_${lang2}_predictions.tsv
    done
    
    scp -i ${key_dir} ${user}@${vm_ip}:${data_dir}/dev-${lang1}.tsv $local_dir/dev_sets/dev-${lang1}.tsv
    
done