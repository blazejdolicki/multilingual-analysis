langs="af ar bg de el en es et eu fa fi fr he hi hu id it ja ko mr nl pt ru ta te tr ur vi zh"
# langs="en"
key_dir="C:/Users/bdolicki/.ssh/blazej-key-pair.pem"
user="ubuntu"
vm_ip="ec2-3-127-69-78.eu-central-1.compute.amazonaws.com"
preds_dir="/home/ubuntu/xtreme/outputs-temp/udpos"
data_dir="/home/ubuntu/xtreme/download/udpos"
local_dir="C:/Users/bdolicki/Documents/Git/multilingual-analysis/code/analysing_predictions/udpos"
folders="results dev_sets"
for folder in $folders; do
    if [ ! -d "${local_dir}/${folder}" ]; then
        mkdir ${local_dir}/${folder}
        echo "Created ${local_dir}/${folder}"
    fi
done

for lang1 in $langs; do
    for lang2 in $langs; do
        scp -i ${key_dir} ${user}@${vm_ip}:${preds_dir}/xlm-roberta-base-LR2e-5-epoch-MaxLen128-train-${lang1}/dev_${lang2}_predictions.txt $local_dir/results/dev_${lang1}_${lang2}_predictions.txt
    done
    
    scp -i ${key_dir} ${user}@${vm_ip}:${data_dir}/dev-${lang1}.tsv $local_dir/dev_sets/dev-${lang1}.tsv
    
done