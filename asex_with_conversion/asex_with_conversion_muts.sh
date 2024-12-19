#!/bin/bash

#SBATCH --nodes=1
#SBATCH --mem=180g
#SBATCH --ntasks-per-node=16
#SBATCH --time=48:00:00
#SBATCH --partition=long
#SBATCH --job-name=slim
#SBATCH --output /data/zool-barralab/scro4331/job_stdout/job_%x_%A_%a.out
#SBATCH -a 0-99%100

module load Anaconda3/2021.11
source activate slim

DIR=/data/zool-barralab/scro4331/simon
MUT=5.0e-09
L=1e7
SEX_FREQ=0.0
TRACT_LEN=5000
N=1000
GENS=50000
REP=$SLURM_ARRAY_TASK_ID

GC_RATE_array=(1.0e-05 1.0e-06 1.0e-07 1.0e-08 1.0e-09) 
D_array=(0.1 0.5)

for GC_RATE in "${GC_RATE_array[@]}"; do
	for D in "${D_array[@]}"; do
		mkdir -p ${DIR}/output/fitness/${GC_RATE}/${D}/
		mkdir -p ${DIR}/output/vcf/${GC_RATE}/${D}/
		slim -d GC_RATE=$GC_RATE -d D=$D -d MUT=$MUT -d L=$L -d SEX_FREQ=$SEX_FREQ -d TRACT_LEN=$TRACT_LEN -d N=$N -d GENS=$GENS -d "FIT_FILE='${DIR}/output/fitness/${GC_RATE}/${D}/${REP}.txt'" -d "VCF_FILE='${DIR}/output/vcf/${GC_RATE}/${D}/${REP}.vcf'" ${DIR}/asex_with_conversion_muts.slim
	done
done