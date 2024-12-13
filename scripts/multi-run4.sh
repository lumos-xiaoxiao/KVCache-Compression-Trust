#!/bin/bash

# declare -a folders=( "fairness" "machine_ethics" "adv_demonstration" "advglue" "ood" "privacy" "stereotype" "toxicity")
declare -a folders=("ood")

# command="dt-run --config-name slurm_config --multirun +model_config=local"
command="dt-run --multirun +model_config=local"

for folder in "${folders[@]}"; do
    # get all config names without the .yaml extension
    configs=$(ls src/dt/configs/${folder}/*.yaml | xargs -n 1 basename | sed 's/.yaml//' | tr '\n' ',' | sed 's/,$//')
   
    # construct the full command
    full_command="${command} +${folder}=${configs}"
    
    # # print the current command
    # echo "Running command: ${full_command}"

    eval "${full_command}"
done

# run the constructed command
#eval $command