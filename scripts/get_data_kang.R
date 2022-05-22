library(preprocessCore)
library(tidyverse)
library(GEOquery)
library(biomaRt)
library(oligo)

# # Get data from geo
gse <- getGEO("GSE25219", GSEMatrix = TRUE)

# kang = getGEOSuppFiles("GSE25219", baseDir="/Users/ulas/Projects/msc_thesis/data/raw", makeDirectory = FALSE)

cel_files = list.files("/Users/ulas/Projects/msc_thesis/data/raw/GSE25219_RAW", full.names=TRUE, pattern="CEL")
data = read.celfiles(cel_files)

ppdata = rma(data, background=TRUE, normalize=FALSE, target="core")

exprdata = exprs(ppdata)
# # Save meta data
# mdt = pData(data)
# readr::write_rds(mdt, "/Users/ulas/Projects/msc_thesis/data/kang_metadata.rds")
# 
# # Exctract ages
# agemap = mdt %>%
#   dplyr::select("geo_accession", "age:ch1") %>%
#   dplyr::rename(age = "age:ch1") %>%
#   filter(age>0)

# # Get ensembl gene IDs
# gmap = fData(data) %>%
#   dplyr::select(ID, Entrez_Gene_ID, Gene_Symbol)
# 
# ensmbl = getBM(attributes = c('hgnc_symbol', 'ensembl_gene_id'),
#                filters = 'hgnc_symbol', 
#                values = gmap$Gene_Symbol, 
#                mart = useMart("ensembl",dataset="hsapiens_gene_ensembl")) %>%
#   rename(Gene_Symbol = hgnc_symbol, Ensembl_ID = ensembl_gene_id)
# 
# genemap = gmap %>%
#   left_join(ensmbl, by="Gene_Symbol") %>%
#   drop_na()

# Get expression data
expr = exprs(data) %>%
  as.data.frame() %>%
  rownames_to_column(var="gnames") %>%
  dplyr::select(gnames, agemap$geo_accession) %>% 
  filter(gnames %in% unique(genemap$ID)) %>%
  mutate(gnames = setNames(genemap$Ensembl_ID, genemap$ID)[gnames]) %>%
  group_by(gnames) %>%
  summarise_all(list(~mean)) %>%
  tibble::column_to_rownames(var="gnames") %>%
  as.matrix()

rm(list=setdiff(ls(), c("agemap", "expr")))

# readr::write_rds(list(expr = expr, age = agemap), "~/Drive/Aging/data/processed/colantuoni_processed.rds")

