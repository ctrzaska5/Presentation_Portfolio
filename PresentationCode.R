
## Load Packages
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(patchwork)
library(readxl)


## Load and Clean Data
UN_ExRates <- read_excel("UN_ExRates.xlsx")
View(UN_ExRates)

UN_ExRates <- UN_ExRates |>
  rename(Country = ...2)


##Crate First Visualization of Euro - USD Exchange Rate over Time
EU_over_time=
  UN_ExRates|>
  filter(`National currency` == "Euro (EUR)", Country == "Euro Area", Series == "Exchange rates: end of period (national currency per US dollar)")|>
  ggplot(aes(x = `Year`, y = Value))+
  geom_line(linewidth = 1, color = "green")+
  theme(
    axis.title = element_text(size = 16)
  )+
  theme_bw()+
  labs(x = "Year", y = "Exchange Rate (USD per EUR)")+
  scale_y_continuous(
    limits = c(0.70, 1.0) 
  )+
  ggtitle("USD/Eur Exchange Rate by Year")

EU_over_time



#Create First Part of the Second Visualization, Comparing 5 currency exchange rates over time
comparison_col=
  UN_ExRates|>
  filter(Country %in% c("Euro Area", "Canada", "Australia", "United Kingdom", "Switzerland"), Series == "Exchange rates: end of period (national currency per US dollar)", Year == "2022")|>
  ggplot(aes(x = Country, y = Value, fill = Country))+
  geom_col()+
  labs(x = "Country", y = "Exchange Rate (USD per Currency)")+
  ggtitle("Exchange Rate by Year")+
  theme_bw()



##Create Second Part of Second Visualization, highlighting current global exchange rates of the 5 currencies previously visualized
comparison_line=
  UN_ExRates|>
  filter(Country %in% c("Euro Area", "Canada", "Australia", "United Kingdom", "Switzerland"), Series == "Exchange rates: end of period (national currency per US dollar)")|>
  ggplot(aes(x = Year, y = Value, color = Country))+
  geom_line()+
  labs(x = "Country", y = "Exchange Rate (USD per Currency)")+
  ggtitle("Exchange Rate by Year")+
  scale_x_continuous(
    limits = c(2005, 2022)
  )+
  theme_bw()
  

##Combine the two visuals using patchwork to create one plot to enter in the final slide
comp_final <- comparison_col + comparison_line +
  plot_layout(ncol = 2)

comp_final