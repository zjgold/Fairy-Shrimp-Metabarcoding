#Code for Conducting Analyses of eDNA Metabarcoding bioassessment of endangered fairy shrimp (Branchinecta spp.)
#Authors:
#Zachary Gold1 (ORCID: 0000-0003-0490-7630), Adam R. Wall2 (ORCID 0000-0002-2223-6757),
#Paul Barber1 (ORCID: 0000-0002-1486-8404), Emily E. Curd1(ORCID: 0000-0003-0336-6852) , Ryan P. Kelly3, N. Dean Pentcheff2(ORCID: 0000-0002-4049-3941) , Lee Ripma4, Regina Wetzer2 (ORCID: 0000-0003-2674-5150)

#Affiliations
#1Department of Ecology and Evolutionary Biology, UCLA, Los Angeles, CA 90005, USA
#2Natural History Museum of Los Angeles County, Los Angeles, CA 90007, USA
#3School of Marine and Environmental Affairs, University of Washington, Seattle, WA, 98105
#4Department of Biology, San Diego State University, San Diego, CA 92182, USA


#Load libraries
library(wesanderson)
library(ggplot)
library(grid)

#Load in Data
#eDNA Data Table for B.sandiegonensis
edna_san <- read.csv("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/vpdata_wOccupancy_edna_sum_taxonomy.san2020-01-23.csv")
#Dip net Data Table for B.sandiegonensis
dip_san <- read.csv("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/vpdata_wOccupancy_dip_by_sample_sum_taxonomy.san2020-01-17.csv")

#eDNA Data Table for B. lindahli
edna_lin <- read.csv("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/vpdata_wOccupancy_edna_sum_taxonomy.lin2020-01-23.csv")
#Dip Net Data Table for B. lindahli
dip_lin <- read.csv("/Users/zackgold/Documents/UCLA_phd/Projects/California/Vernal_pool/sequencing/Vernal_pool_eec_2019/analysis_2020/to_ryan/vpdata_wOccupancy_dip_by_sample_sum_taxonomy.lin2020-01-17.csv")

#Convert to Factors
edna_lin$Site <- factor(edna_lin$Site, levels(edna_lin$Site)[c(1,3:10,2)])
edna_san$Site <- factor(edna_san$Site, levels(edna_san$Site)[c(1,3:10,2)])
dip_lin$Site <- factor(dip_lin$Site, levels(dip_lin$Site)[c(1,3:10,2)])
dip_san$Site <- factor(dip_san$Site, levels(dip_san$Site)[c(1,3:10,2)])

#Generate Color Palletes
col_dar2 <- wes_palette("Darjeeling2",4)
col_dar1 <- wes_palette("Darjeeling1",4)

#B. sandiegonensis Comparisons
#Generate eDNA Heat Map Plot
p1 <- ggplot(edna_san, aes(Date, Site, fill= mean)) + 
  geom_tile() +
  scale_fill_gradient(low="white", high=col_dar1[2], na.value = "grey50", limits = c(0,1), breaks = c(0, .25, .5, .75, 1)) +
  ggtitle("eDNA - B. sandiegoensis") +
  labs(fill = "Occupancy \n Probability") +
  theme(plot.title = element_text(hjust = 0.5,size = 30, face = "bold"),
        axis.text=element_text(size=20),
        axis.title=element_text(size=24,face="bold"),
        legend.title=element_text(size=20),
        legend.text=element_text(size=18)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),legend.position = "none") +
  scale_y_discrete(limits = rev(levels(edna_san$Site))) 

#Generate Dip Net Heat Map Plot
p2 <- ggplot(dip_san, aes(Date, Site, fill= mean)) + 
  geom_tile() +  
  scale_fill_gradient(low="white", high=col_dar1[2], na.value = "grey50", limits = c(0,1), breaks = c(0, .25, .5, .75, 1))+
  ggtitle("Dip Net - B. sandiegoensis")+ labs(fill = "Occupancy \n Probability") +
  theme(plot.title = element_text(hjust = 0.8,size = 30, face = "bold"),
         axis.text=element_text(size=20),
         axis.title=element_text(size=24,face="bold"),
         legend.title=element_text(size=20),
         legend.text=element_text(size=14)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank()) +
  scale_y_discrete(limits = rev(levels(edna_san$Site))) 

#Plot Both Heat Maps
multiplot(p1,p2,  cols=2)

#B. lindahli Comparisons
#Generate eDNA Heat Map Plot
p3 <- ggplot(edna_lin, aes(Date, Site, fill= mean)) + 
  geom_tile() + scale_fill_gradient(low="white", high=col_dar2[2], na.value = "grey50", limits = c(0,1), breaks = c(0, .25, .5, .75, 1)) +
  ggtitle("eDNA - B. lindahli") + labs(fill = "Occupancy \n Probability") +
  theme(plot.title = element_text(hjust = 0.5,size = 30, face = "bold"),
        axis.text=element_text(size=20),
        axis.title=element_text(size=24,face="bold"),
        legend.title=element_text(size=20),
        legend.text=element_text(size=18)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),legend.position = "none") +
  scale_y_discrete(limits = rev(levels(edna_lin$Site))) 

#Generate Dip Net Map Plot
p4 <- ggplot(dip_lin, aes(Date, Site, fill= mean)) + 
  geom_tile() +  scale_fill_gradient(low="white", high=col_dar2[2], na.value = "grey50", limits = c(0,1), breaks = c(0, .25, .5, .75, 1)) +
  ggtitle("Dip Net - B. lindahli")+ labs(fill = "Occupancy \n Probability") +
  theme(plot.title = element_text(hjust = 0.8,size = 30, face = "bold"),
        axis.text=element_text(size=20),
        axis.title=element_text(size=24,face="bold"),
        legend.title=element_text(size=20),
        legend.text=element_text(size=14)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank()) +
  scale_y_discrete(limits = rev(levels(edna_san$Site))) 

multiplot(p3,p4,  cols=2)

