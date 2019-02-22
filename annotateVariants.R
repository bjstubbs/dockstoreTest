args = commandArgs(trailingOnly=TRUE)
BiocManager::install('variants', version = '3.9', update=TRUE, ask=FALSE);
library('variants');
file <- system.file('vcf', 'NA06985_17.vcf.gz', package = 'cgdv17');
genesym <- args[1];
geneid <- select(org.Hs.eg.db, keys=genesym, keytype='SYMBOL',
	columns='ENTREZID');
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene;
seqlevelsStyle(txdb) = 'NCBI';
txdb <- keepSeqlevels(txdb, '17');
txbygene = transcriptsBy(txdb, 'gene');
gnrng <- unlist(range(txbygene[geneid[['ENTREZID']]]), use.names=FALSE);
names(gnrng) <- geneid[['SYMBOL']];
param <- ScanVcfParam(which = gnrng+args[2], info = 'DP', geno = c('GT', 'cPd'));
vcf <- readVcf(file, 'hg19', param);
ans = locateVariants(vcf, txdb, AllVariants());
table(mcols(ans)[['LOCATION']]);
names(ans) = make.names(names(ans),unique=TRUE);
fname=paste0(args[1],".csv")
write.csv(as.data.frame(ans[,1:12]), file=fname);
