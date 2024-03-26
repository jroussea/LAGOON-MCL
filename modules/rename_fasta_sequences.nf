/*
* Processus : renomme les séquences fasta et les mets dans un seul fichier fasta
* Le ouveaux nom du type : seq1, seq2, seq3, seqX
* il est compris entre 1 et le nombre total de séquence
*
* Input:
* 	- 1 ou plusieur fichier fasta
* Output:
*	- 1 ficheir fasta contenant toutes les séquences
*	- 1 table de ccorespondance / fichier fasta entre le nouveau et l'ancien nom de chaque séquence
*/

process RenameFastaSequences {
	tag "Step 1"

	label "general_setting"

	publishDir "${params.outdir}", mode: 'copy', pattern: "${params.concat_fasta}.rename.fasta"

	input:
		path all_sequences

	output:
		path "${params.concat_fasta}.rename.fasta", emit: fasta_rename
		path "${params.concat_fasta}.correspondence_table" , emit: cor_table

	script:
		"""

		seqkit seq -n $all_sequences > ${params.concat_fasta}.name.lst

		awk '/^>/{print ">seq" ++i; next}{print}' < $all_sequences > ${params.concat_fasta}.rename.fasta

		seqkit seq -n ${params.concat_fasta}.rename.fasta > ${params.concat_fasta}.rename.lst
	
		paste ${params.concat_fasta}.name.lst ${params.concat_fasta}.rename.lst > ${params.concat_fasta}.correspondence_table

		"""
}