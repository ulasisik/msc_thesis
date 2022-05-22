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

p1 = exprs(data_cbc) ### raw

## RMA Correction
ppdata_cbc = rma(data_cbc, background=TRUE, normalize=FALSE, target="core")

## Get expressions
expr_cbc = exprs(ppdata_cbc)
colnames(expr_cbc) = gsub(".CEL.gz", "", colnames(expr_cbc))
p2 = 2^expr_cbc[,human_samples]   # rma-cor exprs


p3 = log2(p2)    # rma + lg2

## Quantile normalization
p4 = normalize.quantiles(p3)  # rma + lg2 + qn
rownames(p4) = rownames(p3)
colnames(p4) = colnames(p3) 


mydf = bind_rows(
  data.frame(exp=c(p1), lab="Raw Expr. Values"),
  data.frame(exp=c(p2), lab="RMA Cor."),
  data.frame(exp=c(p3), lab="RMA Cor. + Log2 Trans."),
  data.frame(exp=c(p4), lab="RMA Cor. + Log2 Trans. + QN")
)
rm(list=setdiff(ls(), "mydf"))

pp = ggplot(mydf, aes(x=exp)) +
  geom_histogram(bins=80, color="white", fill="darkslategrey") +
  facet_wrap(~lab, nrow=2, scales = "free") +
  xlab("Gene Expression") +
  ylab("Frequency") +
  theme_bw()
ggsave("/Users/ulas/Projects/msc_thesis/figures/figure2_2.png", pp, units = "cm", width = 18, height = 12)
