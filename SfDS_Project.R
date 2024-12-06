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
# install.packages("gganimate")
# install.packages("gapminder")
# install.packages("mapproj")

library(readxl)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggmap)
library(maps)
library(mapdata)
library(visdat)
library(skimr)
library(gganimate)
library(gapminder)
library(mapproj)


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
# Number of Dead -> Total number of confirmed deaths (bodies recovered). 
#                   Left blank if only missing persons are reported.
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

# Uniformize the values of the "Country of Origin" NA values ("Unknown")
missing_migrants_clean$`Country of Origin` <- ifelse(is.na(missing_migrants_clean$`Country of Origin`), "Unknown", missing_migrants_clean$`Country of Origin`)

# Value counts (n & %) for the "Cause of Death" variable
missing_migrants_clean %>%
  count(`Cause of Death`, sort = TRUE) %>%
  mutate(percentage = round(n / sum(n) * 100, 1)) %>%
  as.data.frame()



# ------------------------------------
### Data Visualization ###
# Source: https://www.kaggle.com/code/akyabahmed/maping-global-missing-migrants/notebook

### Data Visualization ###

# Prepare the data
map_data_clean <- missing_migrants_clean %>%
  filter(!is.na(`Coordinates`)) %>%
  mutate(
    lat = as.numeric(sub(",.*", "", `Coordinates`)), # Extract latitude
    lon = as.numeric(sub(".*,", "", `Coordinates`)), # Extract longitude
    year = `Incident Year`
  ) %>%
  na.omit() # Remove rows with missing coordinates

# Order the YearMonth field
map_data_clean <- map_data_clean %>%
  mutate(
    # Create a DateOrder field to ensure proper ordering
    DateOrder = as.Date(paste(`Incident Year`, `Month`, "01", sep = " "), format = "%Y %B %d"),
    YearMonth = factor(YearMonth, levels = unique(YearMonth[order(DateOrder)])) # Order YearMonth by DateOrder
  )

# Check the ordered levels
levels(map_data_clean$YearMonth)


# Load world map data
world <- map_data("world")

# Create the animated map
map_animation <- ggplot() +
  geom_polygon(
    data = world,
    aes(x = long, y = lat, group = group),
    fill = "lightgray", color = "white", linewidth = 0.1
  ) +
  coord_map(xlim = c(-100, 50), ylim = c(0, 55)) +
  geom_point(
    data = map_data_clean,
    aes(
      x = lon, y = lat,
      color = `Total Number of Dead and Missing`,
      size = `Total Number of Dead and Missing` * 20
    ),
    alpha = 0.8
  ) +
  scale_color_gradient(low = "lightpink", high = "darkred", name = "Total Dead & Missing") +
  scale_size_continuous(range = c(1, 15), name = "") +
  labs(
    title = "Global Missing Migrants Incidents by Year and Month",
    subtitle = "Year-Month: {frame_time}",
    x = "Longitude", y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18),
    legend.position = "bottom",
    plot.subtitle = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12)
  ) +
  transition_time(as.Date(YearMonth)) +
  ease_aes('linear')

# Show the animation
animate(map_animation, length(unique(map_data_clean$YearMonth)), 
        fps = 2, width = 800, height = 500, renderer = gifski_renderer())

# Save the animation as a GIF
animate(map_animation, nframes = (max(map_data_clean$year) - min(map_data_clean$year) + 1), 
        fps = 2, width = 1000, height = 600, 
        renderer = gifski_renderer("map_animation.gif"))




# ------------------------------------
### Polar Charts ###

### Polar Charts ###

# Aggregate data for polar charts by year
polar_data <- missing_migrants_clean %>%
  group_by(`Incident Year`) %>%
  summarise(
    Deaths = sum(`Number of Dead`, na.rm = TRUE),
    Missing = sum((`Total Number of Dead and Missing` - `Number of Dead`), na.rm = TRUE),
    Survivors = sum(`Number of Survivors`, na.rm = TRUE),
    Incidents = n()
  ) %>%
  pivot_longer(
    cols = -`Incident Year`,
    names_to = "Category",
    values_to = "Count"
  )

# Create polar charts with facets for each category
polar_plot <- ggplot(polar_data, aes(x = as.factor(`Incident Year`), y = Count, fill = as.factor(`Incident Year`))) +
  geom_bar(stat = "identity", width = 1, color = "white", alpha = 0.8) +
  coord_polar(theta = "x") +
  
  # Custom color palette
  scale_fill_manual(
    values = colorRampPalette(c("darkred", "red", "lightcoral"))(length(unique(polar_data$`Incident Year`))),
    guide = "none" # Removes the legend
  ) +
  labs(
    title = "Polar Charts of Migrant Incidents Over Years",
    subtitle = "Distribution of Deaths, Missing, Survivors, and Incidents by Year\n",
    x = NULL, y = NULL
  ) +
  facet_wrap(~ Category, ncol = 2, scales = "free_y") +
  theme_minimal() +
  theme(
    strip.text = element_text(size = 12, face = "bold"),                     # Bold category titles
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),        # Center title
    plot.subtitle = element_text(size = 12, face = "bold", hjust = 0.5),     # Center subtitle
    axis.text.x = element_text(size = 10, face = "bold"),                    # Bold axis text
    legend.position = "none"                                                 # Removes the legend entirely
  )

# Display the polar chart
polar_plot
