# Preprocessing of Somel2011_CBC
library(preprocessCore)
library(tidyverse)
library(GEOquery)
library(biomaRt)
library(oligo)
library(ggpubr)

# Get Metedata
gse_cbc =  getGEO("GSE22569")[[1]]

# Extract sample (individual) and feature (gene/probe set info) info
cbc_sample = pData(gse_cbc)
cbc_feature = fData(gse_cbc)

human_samples = cbc_sample %>%
  filter(organism_ch1 == "Homo sapiens") %>% 
  pull(geo_accession)

## Read CEL files
cel_cbc_files = list.files("/Users/ulas/Projects/msc_thesis/data/raw/GSE22569_RAW", full.names=TRUE, pattern="CEL")
data_cbc = read.celfiles(cel_cbc_files)

## RMA Correction
ppdata_cbc = rma(data_cbc, background=TRUE, normalize=FALSE, target="core")

## Get expressions
expr_cbc = exprs(ppdata_cbc)
colnames(expr_cbc) = gsub(".CEL.gz", "", colnames(expr_cbc))
raw_expr_cbc = 2^expr_cbc[,human_samples]

## Plot data to make sure it is right skewed
graphics::hist(raw_expr_cbc, breaks=90)
oligo::boxplot(raw_expr_cbc)

## log 2 and plot again
lg2_exprs = log2(raw_expr_cbc)
graphics::hist(lg2_exprs, breaks=90)
oligo::boxplot(lg2_exprs)

## Quantile normalization
qn_exprs = normalize.quantiles(lg2_exprs)
rownames(qn_exprs) = rownames(lg2_exprs)
colnames(qn_exprs) = colnames(lg2_exprs)
graphics::hist(qn_exprs, breaks=90)
oligo::boxplot(qn_exprs)

## Get ensembl gene IDs
gmap = t(apply(cbc_feature, 1, function(x) c("ID" = x[1], "hgnc_symbol" = str_split(x[10], " // ")[[1]][2]) )) %>%
  as.data.frame()

ensmbl = getBM(attributes = c('hgnc_symbol', 'ensembl_gene_id'),
      filters = 'hgnc_symbol', 
      values = gmap$hgnc_symbol, 
      mart = useMart("ensembl",dataset="hsapiens_gene_ensembl"))
gnames = ensmbl %>% 
  right_join(gmap, by="hgnc_symbol") %>%
  dplyr::rename(ID = ID.ID)

# Take mean if multiple probeset corresponds to same gene
gexpr = qn_exprs %>%
  as.data.frame() %>%
  rownames_to_column("ID") %>%
  left_join(gnames, by="ID") %>%
  drop_na() %>%
  dplyr::select(-c(ID, hgnc_symbol)) %>%
  group_by(ensembl_gene_id) %>%
  summarise_all(list(mean=mean)) %>%
  column_to_rownames("ensembl_gene_id") %>%
  dplyr::rename_all(funs(gsub("_mean", "", .)))




