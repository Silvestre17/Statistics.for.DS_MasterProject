################################################################################
#                Statistics for Data Science Project - Group 37                #
#                                                                              #
# Authors:                                                                     #
# - André Filipe Gomes Silvestre (20240502)                                    #
# - Umeima Adam Mahomed (20240543)                                             #
################################################################################

# Load libraries
# install.packages("readxl")
# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("ggmap")
# install.packages("maps")
# install.packages("mapdata")
# install.packages("visdat")
# install.packages("skimr")

library(readxl)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggmap)
library(maps)
library(mapdata)
library(visdat)
library(skimr)



# Load data
missing_migrants <- read_excel("./Missing_Migrants_Global_Figures_allData.xlsx")

# Shape of the data
dim(missing_migrants)

# First 6 rows of the data
head(missing_migrants)

# ------------------------------------

# Check for duplicated rows
sum(duplicated(missing_migrants))

# List of Columns
colnames(missing_migrants)

# Structure of the data
str(missing_migrants)
  
# Summary of the data
summary(missing_migrants)

# Advanced summary of the data
skim(missing_migrants)

# ------------------------------------
#### Description of the variables ####
# Source: https://missingmigrants.iom.int/methodology

# Web ID (Main ID + Incident ID) -> An automatically generated number used to identify each unique entry in the dataset.
# [+] Incident Type -> The type of incident in which the migrant(s) died or went missing.
#                      Possible values include "Incident", "Split Incident", "Cumulative Incident"
# Region of Incident -> The region in which an incident took place. 
#                       For more about regional classifications used in the dataset, click here.
# Incident Date -> Estimated date of death. 
#                  If unknown, the date indicates when bodies were found or reported by witnesses/interviews.
# Incident Year -> The year in which the incident occurred.
# Incident Month -> The month in which the incident occurred.
# Number Dead -> Total number of confirmed deaths (bodies recovered). 
#                Left blank if only missing persons are reported.
# Number Missing -> Total number of missing persons assumed to be dead, often reported in cases of shipwrecks. 
#                   Left blank if none.
# Total Dead and Missing -> The sum of the ‘number dead’ and ‘number missing’ variables.
# Number of Survivors -> Total number of migrants that survived the incident, if known.
# Number of Females -> Number of females found dead or missing, based on third-party interpretations.
# Number of Males -> Number of males found dead or missing, based on third-party interpretations.
# Number of Children -> Number of individuals under the age of 18 found dead or missing.
# Country of Origin -> Country of birth of the decedent. Marked as “unknown” if not available.
# Region of Origin -> Region of origin of the decedent(s). 
#                     Marked as “Presumed” if deduced based on location or “unknown” if not available.
# Cause of Death -> Circumstances resulting in the migrant's death. 
#                   Includes additional notes if unknown (e.g., "Unknown – skeletal remains only").
# Location Description -> Description of the place where death(s) occurred or where the body or bodies were found. 
#                         Includes nearby landmarks when possible.
# Location Coordinates -> Geographic coordinates of the incident location. 
#                         Coordinates may be estimated, especially in regions like the Mediterranean.
# Migration Route -> Name of the migrant route where the incident occurred, if known. 
#                    Left blank if unknown.
# UNSD Geographical Grouping -> Geographical region of the incident as per the United Nations Statistics Division (UNSD) geoscheme.
# Information source -> Name of the information source for the incident. 
#                       Multiple sources may be listed.
# Link -> Links to original reports of migrant deaths/disappearances, if available. 
#         Multiple links may be listed.
# Source quality -> Rank (1-5) indicating the reliability of the source(s) of information.
#                   Level 1: Single media source.
#                   Level 2: Uncorroborated eyewitness accounts or survey data.
#                   Level 3: Multiple media reports.
#                   Level 4: At least one NGO, IGO, or humanitarian actor with direct knowledge.
#                   Level 5: Official sources (e.g., coroners, government officials) or multiple humanitarian actors.

# ------------------------------------

# Value counts (n & %) for the "Incident Type" variable
missing_migrants %>%
  count(`Incident Type`, sort = TRUE) %>%
  mutate(percentage = round(n / sum(n) * 100, 1)) %>%
  as.data.frame()

# Filter the data with the "Incident Type" variable equal to "Incident"
missing_migrants_clean <- missing_migrants
missing_migrants_clean <- missing_migrants_clean %>%
  filter(`Incident Type` == "Incident")


# Drop columns that are not useful - "Main ID", "Incident ID"
missing_migrants_clean <- missing_migrants_clean %>% 
  select(-c("Main ID", "Incident ID"))

# Uniformize the NA values
missing_migrants_clean[missing_migrants_clean == ''] <- NA


# Define the size of the plot and Representation of the data type and NAs
options(repr.plot.width = 10, repr.plot.height = 10)
visdat::vis_dat(missing_migrants_clean, sort_type = FALSE)

# List the number of NAs and respective percentage for each variable
missing_migrants_clean %>%
  summarise_all(~sum(is.na(.))) %>%
  gather(variable, na_count) %>%
  mutate(na_percentage = round((na_count / nrow(missing_migrants_clean) * 100),1)) %>%
  arrange(desc(na_percentage)) %>%
  as.data.frame()

# ------------------------------------

# List of unique values for each variable
missing_migrants_clean %>%
  summarise_all(~length(unique(.))) %>%
  gather(variable, unique_count) %>%
  arrange(desc(unique_count)) %>%
  as.data.frame()

# List of unique values for categorical variables
missing_migrants_clean %>%
  select_if(is.character) %>%
  summarise(across(everything(), ~ list(unique(.)))) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "unique_values") %>%
  mutate(unique_count = sapply(unique_values, length)) %>%   # Count the number of unique values
  filter(unique_count < 100) %>%                             # Filter only the variables with less than 100 unique values
  select(-unique_count) %>%                                  # Drop the unique_count column
  as.data.frame()


# ------------------------------------
### Data Cleaning ###

# Uniformize the values of the "Incident Type" variable - "Incident", "Split Incident", "Cumulative Incident"
unique(missing_migrants_clean$`Incident Type`)

# "Incident,Split Incident" -> "Split Incident"
missing_migrants_clean$`Incident Type` <- gsub("Incident,Split Incident", "Split Incident", missing_migrants_clean$`Incident Type`)
missing_migrants_clean$`Incident Type` <- as.factor(missing_migrants_clean$`Incident Type`)
unique(missing_migrants_clean$`Incident Type`)

# Uniformize the values of the "Country of Origin" NA values ("Unknown")
missing_migrants_clean$`Country of Origin` <- ifelse(is.na(missing_migrants_clean$`Country of Origin`), "Unknown", missing_migrants_clean$`Country of Origin`)


