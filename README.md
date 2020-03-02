# Fairy-Shrimp-Metabarcoding
Code to conduct data analysis for eDNA Metabarcoding bioassessment of endangered fairy shrimp (Branchinecta spp.)  

## Decontamination
The decontamination scripts were conducted in R to process the Anacapa Toolkit generated ASV tables.   

### Input data includes the following:
a) Two metadata files - vp_meta_data.txt and vp_meta_data_3.txt    
b) Hash File with taxonomic paths for each ASV - vp_hashes_01072019.txt   
c) Two raw output ASV tables from Anacapa Toolkit from each sequencing run - vp1_Metazoa_16S_ASV_raw_taxonomy_60_edited.txt and vp2_16S_ASV_raw_tax_60_edited.txt    

### Code to run decontamination:
vernal_pool_decontamination_01072020.Rmd 

Thanks for Ramon Gallego https://github.com/ramongallego?tab=repositories and Ryan Kelly https://github.com/invertdna for help implementing the code.  

## Site Occupancy Modeling
The site occupancy modeling scripts were conducted in R to process the decontaminated Branchinecta ASV tables.    

### Input data includes:
a) Transformed eDNA Data - 16S_decontaminated_table_only3_t-10.csv   
b) Dip net data - dip_net_presence_absence.csv   

### Code to run SOM includes:
a) SOM for eDNA data - vp_Occupancy_Stan_edna_01232020.R   
b) SOM for Dip net data - dip_net_occupancy_by_sample.R   

## Data Analysis
The heat map plot scripts were conducted in R to plot the calculated occupancy rates for B. sandiegonensis and B. lindahli.    

### Input data includes:
a) B. lindahli dip net data - vpdata_wOccupancy_dip_by_sample_sum_taxonomy.lin2020-01-17.csv    
b) B. sandiegonensis dip net data - vpdata_wOccupancy_dip_by_sample_sum_taxonomy.san2020-01-17.csv    
c) B. lindahli eDNA data - vpdata_wOccupancy_edna_sum_taxonomy.lin2020-01-23.csv  
d) B. sandiegonensis eDNA data - vpdata_wOccupancy_edna_sum_taxonomy.san2020-01-23.csv  

### Code to run data analysis:
a) Plotting Heat Maps of Occupancy Rates - occupancy_heat_map_01232020_t10_3only.R  
b) Multiplot function - multiplot.r (http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/)  

