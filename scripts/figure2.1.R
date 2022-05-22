library(tidyverse)

all_ages = readRDS("/Users/ulas/Projects/msc_thesis/data/processed/list_all_ages.rds")

mydf = all_ages %>%
  reshape2::melt() %>%
  dplyr::rename(age=value, dataset=L1) %>%
  mutate(dataset = gsub("_dev", "", dataset),
         dataset = gsub("_age", "", dataset),
         dataset = gsub("2010", "2011", dataset),
         agedays = age,
         age025 = age^0.25,
         ageyears = agedays/365,
         datasource = sapply(dataset, function(x) strsplit(x,"_",fixed=T)[[1]][1]),
         ageint = as.character(cut(ageyears, breaks=seq(0,100,by=10), include.lowest=T)),
         ageint025 = cut(age025, breaks=seq(0,14,by=0.5), include.lowest=T),
         ageint = gsub("[", "(", ageint,fixed=T))


p1 = mydf %>%
  group_by(datasource, ageint) %>%
  summarise(n = n()) %>%
  ggplot(aes(x=ageint, y=n, fill=datasource)) +
  geom_bar(stat="identity", color="white") +
  scale_fill_manual(values = c("#88CCEE", "#CC6677","#332288"),
                     name = "Data Sources") + 
  ylab("Number of Samples") + xlab("Age") +
  ggtitle("a.") +
  theme_light() + 
  theme(axis.text.x=element_text(angle=90))

p2 = mydf %>%
  ggplot(aes(age025, fill=datasource)) +
  geom_density(alpha=0.4) + 
  geom_vline(xintercept=(20*365)^0.25, linetype=2, color="dark red") +
  scale_fill_manual(values = c("#88CCEE", "#CC6677","#332288"),
                    name = "Data Sources") + 
  scale_x_continuous(breaks = (c(0.01, 20, 100)*365)^0.25,
                     labels = c(0, 20, 100)) +
  ylab("Frequency") + xlab("Age (in fourth root scale)") +
  ggtitle("b.") +
  theme_light()

ggpubr::ggarrange(p1, p2, common.legend = T, legend="right", align = "h")
ggsave("/Users/ulas/Projects/msc_thesis/figures/figure2_1.pdf", width = 9, height = 5)
