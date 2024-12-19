#!/bin/bash

#SBATCH --nodes=1
#SBATCH --mem=180g
#SBATCH --ntasks-per-node=16
#SBATCH --time=00:10:00
#SBATCH --partition=devel
#SBATCH --job-name=slim
#SBATCH --output /data/zool-barralab/scro4331/job_stdout/job_%x_%A_%a.out
#SBATCH -a 0-99%100

module load Anaconda3/2021.11
source activate slim

DIR=/data/zool-barralab/scro4331/chapter1/Simon/simulation_sex
L=1000000 # 1 Mb 
N=1000 # 10000 / 10 
TRACT_LEN=5000
CO_RATE=1.0e-6
MUT_RATE=5.0e-8 # 5.0e-9 * 10
S_MEAN=-0.1 # -0.01 * 10
S_SHAPE=0.2
GENS=50000
REP=$SLURM_ARRAY_TASK_ID


mkdir -p ${DIR}/sim_output/fitness/
mkdir -p ${DIR}/sim_output/genotypes/
mkdir -p ${DIR}/sim_output/ts/
slim \
	-d CO_RATE=$CO_RATE \
	-d MUT_RATE=$MUT_RATE \
	-d S_MEAN=$S_MEAN \
	-d S_SHAPE=$S_SHAPE \
	-d L=$L \
	-d TRACT_LEN=$TRACT_LEN \
	-d N=$N \
	-d GENS=$GENS \
	-d "FITNESS_FILE='${DIR}/sim_output/fitness/${REP}.txt'" \
	-d "GENOTYPE_FILE='${DIR}/sim_output/genotypes/${REP}.txt'" \
	-d "TS_FILE='${DIR}/sim_output/ts/${REP}.trees'" \
	${DIR}/sex_with_crossovers_muts.slim