cd security/DecodingTrust && conda activate dt-test

CUDA_VISIBLE_DEVICES=4 bash scripts/multi-run4.sh
CUDA_VISIBLE_DEVICES=5 bash scripts/multi-run5.sh
CUDA_VISIBLE_DEVICES=6 bash scripts/multi-run6.sh
CUDA_VISIBLE_DEVICES=4,6,7 bash scripts/multi-run7.sh

CUDA_VISIBLE_DEVICES=6 python src/dt/summarize.py

CUDA_VISIBLE_DEVICES=4,6,7 dt-run +model_config=local +toxicity=realtoxicityprompts-nontoxic-adv

CUDA_VISIBLE_DEVICES=6 python src/dt/perspectives/machine_ethics/calculate_score.py

CUDA_VISIBLE_DEVICES=5 dt-run +model_config=local +privacy=email_extraction_context50
CUDA_VISIBLE_DEVICES=7 dt-run +model_config=local +privacy=email_extraction_context200

CUDA_VISIBLE_DEVICES=5 dt-run +model_config=local +machine_ethics=ethics_commonsense_short