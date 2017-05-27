#!/bin/bash

g_type=barabasi_albert

min_n=$1
max_n=$2

data_test=$HOME/data/dataset/rl_comb_opt/data/validation_mvcmaxcut/gtype-$g_type-nrange-$min_n-$max_n-n_graph-100-p-0.00-m-4-w-float-0-1-cnctd-0-seed-5.pkl
#data_test=$HOME/data/dataset/rl_comb_opt/data/validation_mvcmaxcut/gtype-$g_type-nrange-$min_n-$max_n-n_graph-100-p-0.15-m-0-w-float-0-1-cnctd-0-seed-5.pkl

result_root=$HOME/scratch/results/rl_comb_opt/cpp_vc/dqn-$g_type

# max belief propagation iteration
max_bp_iter=5

# embedding size
embed_dim=64

# gpu card id
dev_id=0

# max batch size for training/testing
batch_size=64

net_type=QNet

# set reg_hidden=0 to make a linear regression
reg_hidden=64

# learning rate
learning_rate=0.0001

# init weights with rand normal(0, w_scale)
w_scale=0.01

# nstep
n_step=5

num_env=10
mem_size=500000

max_iter=100000

# folder to save the trained model
save_dir=$result_root/embed-$embed_dim-nbp-$max_bp_iter-rh-$reg_hidden

if [ ! -e $save_dir ];
then
    mkdir -p $save_dir
fi

python evaluate.py \
    -n_step $n_step \
    -dev_id $dev_id \
    -data_test $data_test \
    -min_n $min_n \
    -max_n $max_n \
    -num_env $num_env \
    -max_iter $max_iter \
    -mem_size $mem_size \
    -g_type $g_type \
    -learning_rate $learning_rate \
    -max_bp_iter $max_bp_iter \
    -net_type $net_type \
    -max_iter $max_iter \
    -save_dir $save_dir \
    -embed_dim $embed_dim \
    -batch_size $batch_size \
    -reg_hidden $reg_hidden \
    -momentum 0.9 \
    -l2 0.00 \
    -w_scale $w_scale
