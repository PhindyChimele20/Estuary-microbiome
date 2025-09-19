quast.py illumina_contigs.fasta.gz -o illumina_contigs

prodigal -i illumina_contigs.fasta.gz -o illumina_contigs.gff -a illumina_proteins.fasta -d illumina_genes.fasta

cmscan --rfam --cut_ga --nohmmonly --tblout illumina_contigs.tblout --fmt 2 --clanin Rfam.clanin Rfam.cm illumina_contigs.fasta.gz > illumina_contigs.cmscan
