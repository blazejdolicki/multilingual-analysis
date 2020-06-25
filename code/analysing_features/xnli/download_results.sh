langs="ar bg de el en es fr hi ru sw th tr ur vi zh"
# langs="en"
key_dir="C:/Users/bdolicki/.ssh/blazej-key-pair.pem"
user="ubuntu"
vm_ip="ec2-18-195-167-249.eu-central-1.compute.amazonaws.com"
vm_dir="/home/ubuntu/xtreme/outputs-temp/xnli"
local_dir="C:/Users/bdolicki/Documents/Git/multilingual-analysis/code/analysing_features/xnli/results"
if [ ! -d ${local_dir} ]; then
    mkdir ${local_dir}
    echo "Created ${local_dir}"
fi
for lang in $langs; do
    scp -i ${key_dir} ${user}@${vm_ip}:${vm_dir}/xlm-roberta-base-LR2e-5-epoch5-MaxLen128-train-${lang}/dev_results $local_dir/dev_results_${lang}.txt
done