library(preprocessCore)
library(tidyverse)
library(GEOquery)
library(biomaRt)
library(oligo)

## Get data from geo
gse_cbc =  getGEO("GSE22569")[[1]]

cbc_sample = pData(gse_cbc)
cbc_feature = fData(gse_cbc)
# gse_cbc <- getGEOSuppFiles("GSE22569", baseDir = "/Users/ulas/Projects/msc_thesis/data/raw", makeDirectory = F)
# gse_pfc <- getGEOSuppFiles("GSE18069", baseDir = "/Users/ulas/Projects/msc_thesis/data/raw", makeDirectory = F)

## Read CEL files
cel_cbc_files = list.files("/Users/ulas/Projects/msc_thesis/data/raw/GSE22569_RAW", full.names=TRUE, pattern="CEL")
# cel_pfc_files = list.files("/Users/ulas/Projects/msc_thesis/data/raw/GSE18069_RAW", full.names=TRUE, pattern="CEL")

data_cbc = read.celfiles(cel_cbc_files)
# data_pfc = read.celfiles(cel_pfc_files)

## RMA Correction
ppdata_cbc = rma(data_cbc, background=TRUE, normalize=FALSE, target="core")
# ppdata_pfc = rma(data_pfc, background=TRUE, normalize=FALSE, target="core")

## Get expressions
expr_cbc = exprs(ppdata_cbc)
# expr_pfc = exprs(ppdata_pfc)

oligo::boxplot(expr_cbc)
oligo::hist(expr_cbc)

## Histograms
pdf(file = "/Users/ulas/Projects/msc_thesis/figures/preprocess/plot_raw_somel_cbc.pdf")
boxplot(2^expr_cbc, col="light blue")
for (i in colnames(expr_cbc)) hist(2^expr_cbc[,i], col="light blue", main=i)
dev.off()
pdf(file = "/Users/ulas/Projects/msc_thesis/figures/preprocess/plot_raw_somel_pfc.pdf")
boxplot(2^expr_pfc, col="light blue")
for (i in colnames(expr_pfc)) hist(2^expr_pfc[,i], col="light blue", main=i)
dev.off()

pdf(file = "/Users/ulas/Projects/msc_thesis/figures/preprocess/plot_log2_somel_cbc.pdf")
boxplot(expr_cbc, col="light blue")
for (i in colnames(expr_cbc)) hist(expr_cbc[,i], col="light blue", main=i)
dev.off()
pdf(file = "/Users/ulas/Projects/msc_thesis/figures/preprocess/plot_log2_somel_pfc.pdf")
boxplot(expr_pfc, col="light blue")
for (i in colnames(expr_pfc)) hist(expr_pfc[,i], col="light blue", main=i)
dev.off()

