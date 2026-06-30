while read SAMPLE
do
	sbatch scripts/variant-calling_paralel.sh ${SAMPLE}
done < fastq_ids.txt

