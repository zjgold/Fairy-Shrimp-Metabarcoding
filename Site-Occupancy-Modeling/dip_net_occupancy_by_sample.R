#Code for Conducting Site Occupnacy Modeling of eDNA Metabarcoding bioassessment of endangered fairy shrimp (Branchinecta spp.)
#Authors:
#Zachary Gold1 (ORCID: 0000-0003-0490-7630), Adam R. Wall2 (ORCID 0000-0002-2223-6757),
#Paul Barber1 (ORCID: 0000-0002-1486-8404), Emily E. Curd1(ORCID: 0000-0003-0336-6852) , Ryan P. Kelly3, N. Dean Pentcheff2(ORCID: 0000-0002-4049-3941) , Lee Ripma4, Regina Wetzer2 (ORCID: 0000-0003-2674-5150)

#Affiliations
#1Department of Ecology and Evolutionary Biology, UCLA, Los Angeles, CA 90005, USA
#2Natural History Museum of Los Angeles County, Los Angeles, CA 90007, USA
#3School of Marine and Environmental Affairs, University of Washington, Seattle, WA, 98105
#4Department of Biology, San Diego State University, San Diego, CA 92182, USA

#Load Libraries
library(tidyverse)
library(rethinking)
library(here)
library(shinystan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

#Set Working Directory
setwd("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/")

#Load Dip net Data
dipdata <- read.csv("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/dip_net_presence_absence.csv")

#Convert Dip net data into SOM format
dipdata %>% 
  pivot_longer(., cols = c("Branchinecta_lindahli",	"Branchinecta_sandiegonensis"),
               names_to = "taxa", values_to = "detections") %>%
  mutate(.,Site=Pool, date=Time_point) %>%
  add_column(., k = 1) %>% 
  select(taxa, date, Site, detections, k) %>% 
  rename(Species = taxa,
         Site=Site,
         Date = date,
         N = detections,
         K = k) %>% 
  mutate(SpeciesIdx = match(Species, unique(Species))) %>% distinct()-> dip_2

#Fix Formatting
SDS <- unite(data = dip_2,
             col = SDS,
             c("Site", "Date", "Species")
) %>% pull(SDS)

#Index for unique site-date-species combinations
dip_2$SiteDateSpecies <- match(SDS, unique(SDS))

dataset <-  dip_2

#Select B. sandiegonensis data only
dip_2 %>% 
  filter(., Species=="Branchinecta_sandiegonensis") -> dataset
View(dataset)

#Run SOM on B. sandiegonensis Dip net data
myModel <- stan(file = "occupancy_VernalPools_SiteDateSpeciesProb.stan", 
                data = list(
                  #Y = myData,
                  S = nrow(dataset),
                  K = dataset$K,
                  N = dataset$N,
                  NSpecies = length(unique(dataset$Species)),
                  Species = match(dataset$SpeciesIdx, unique(dataset$SpeciesIdx)),
                  SiteDateSpecies = match(dataset$SiteDateSpecies, unique(dataset$SiteDateSpecies)),
                  NSiteDateSpecies = length(unique(dataset$SiteDateSpecies))
                ), 
                chains = 1)

myModel
#Fit Summary
fit_summary <- summary(myModel, probs = c(0.025, 0.975))$summary    
#launch_shinystan(myModel)

#Select Occupancy Mean Probabilies for B. sandiegonensis
occProbs <- fit_summary[grep("Occupancy_prob", row.names(fit_summary)), c("mean", "2.5%", "97.5%")] %>% 
  round(3) %>% 
  as.data.frame()

#Plot Histogram of B. sandiegonensis mean occupancy rates
hist(occProbs[,1])

#Save B. sandiegonensis Dip net Occupancy Rates
dataset %>% 
  distinct(Species, Site, Date) %>% 
  bind_cols(occProbs) %>% 
  write.csv(paste0("vpdata_wOccupancy_dip_by_sample_sum_taxonomy.san",Sys.Date(),".csv"), row.names = F)

#Select B. lindahli data only
dip_2 %>% 
  filter(., Species=="Branchinecta_lindahli") -> dataset

#Run SOM on B. lindahli Dip net data
myModel.lin <- stan(file = "occupancy_Moncho_SiteDateSpeciesProb.stan", 
                    data = list(
                      #Y = myData,
                      S = nrow(dataset),
                      K = dataset$K,
                      N = dataset$N,
                      NSpecies = length(unique(dataset$Species)),
                      Species = match(dataset$SpeciesIdx, unique(dataset$SpeciesIdx)),
                      SiteDateSpecies = match(dataset$SiteDateSpecies, unique(dataset$SiteDateSpecies)),
                      NSiteDateSpecies = length(unique(dataset$SiteDateSpecies))
                    ), 
                    chains = 1)
myModel.lin

#Fit Summary
fit_summary <- summary(myModel.lin, probs = c(0.025, 0.975))$summary    
#launch_shinystan(myModel)

#Select Occupancy Mean Probabilies for B. sandiegonensis
occProbs <- fit_summary[grep("Occupancy_prob", row.names(fit_summary)), c("mean", "2.5%", "97.5%")] %>% 
  round(3) %>% 
  as.data.frame()

#Plot Histogram of B. lindahli mean occupancy rates
hist(occProbs[,1])

#Save B. lindahli Dip net Occupancy Rates
dataset %>% 
  distinct(Species, Site, Date) %>% 
  bind_cols(occProbs) %>% 
  write.csv(paste0("vpdata_wOccupancy_dip_by_sample_sum_taxonomy.lin",Sys.Date(),".csv"), row.names = F)



