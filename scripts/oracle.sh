#!/bin/sh
# The following lines instruct Slurm to allocate one GPU.
#SBATCH --job-name=oracle
#SBATCH --partition gpu
#SBATCH --gres=gpu:nvidia_titan_v:2
#SBATCH --mem=32G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=15:00:00
#SBATCH --output=logs/%x.%j.out

# Set-up the environment.
source ${HOME}/.bashrc
conda activate selfrag
cd ~/rag-rerank

# Start the experiment.
# python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 0 --ndoc_in_demo 0 --ndoc 5 --used_field text
# python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 1 --ndoc_in_demo 5 --ndoc 5 --used_field text 

# concern is the missing summary
# [BUG] some of the eval data has no `summary`. That will use extraction or full text to replace.
python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 0 --ndoc_in_demo 0 --ndoc 5 --used_field summary --tag oracle-summ 
python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 1 --ndoc_in_demo 5 --ndoc 5 --used_field summary --tag oracle-summ

# concern is the missing follow-up documents, need another file
# python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 1 --ndoc_in_demo 5 --ndoc 10 --used_field summary
# python3 naive.py --config configs/eli5.llama3-8b-chat.oracle.yaml --quick_test 30 --shot 1 --ndoc_in_demo 5 --ndoc 10 --used_field summary

