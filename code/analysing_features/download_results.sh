langs="af ar bg bn de el en es et eu fa fi fr he hi hu id it ja jv ka kk ko ml mr ms my nl pt ru sw ta te th tl ur vi zh"
# langs="en"
key_dir="C:/Users/bdolicki/.ssh/blazej-key-pair.pem"
user="ubuntu"
vm_ip="ec2-18-156-163-12.eu-central-1.compute.amazonaws.com"
vm_dir="/home/ubuntu/xtreme/outputs-temp/panx"
local_dir="C:/Users/bdolicki/Documents/Git/multilingual-analysis/code/analysing_features/ner/results"
if [ ! -d ${local_dir} ]; then
    mkdir ${local_dir}
    echo "Created ${local_dir}"
fi
for lang in $langs; do
    scp -i ${key_dir} ${user}@${vm_ip}:${vm_dir}/xlm-roberta-base-LR2e-5-epoch-MaxLen128-train-${lang}/dev_results.txt $local_dir/dev_results_${lang}.txt
done