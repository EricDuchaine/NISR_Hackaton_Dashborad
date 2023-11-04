# NISR_Hackaton_Dashborad
NISR DASHBOARD

Labor Force Survey Dashboard

Introduction
The Labor Force Survey Dashboard is a web application developed using Shiny and Shinydashboard in R. This dashboard provides interactive visualizations of labor force data from various sheets of an Excel file. The data is visualized across different categories, allowing users to explore and analyze labor force statistics in Rwanda 2022.

Prerequisites
Before running the dashboard, make sure you have the following R packages installed. You can install them using the install.packages() function if they are not already installed:
•	shiny
•	shinydashboard
•	readxl
•	ggplot2
•	tidyr
•	zoo
•	forecast
•	lubridate
•	tidyverse
•	skimr
•	reshape2
•	plotly

Data Source
The dashboard uses data from an Excel file. You should replace "C:/Users/ERIC/Downloads/labor force data.xlsx" with the actual path to your Excel file in the code. The data is organized into different sheets (A to J), and each sheet contains specific labor force statistics. This is for the purpose of making R studio really understand our code efficiently.
Sheet_A: Employed Population by Sex
Sheet_B: Summary labor Force Indicators by Province, RLFS 2022
Sheet_c: Migrant Workers by Sex, Urban/Rural Area
Sheet_D: Indicators of Labor Force
Sheet_E: State of Study for Population in Agriculture
Sheet_F: Population 16 years old and over in trade/attended train courses by sex
Sheet_G: Disabled working-age persons by labor force status and type of disability
Sheet_H: Average monthly cash income from employment of employees at the main job by sex
Sheet_I: Labor participation rate


Usage
1.	Make sure you have the required packages installed.
2.	Replace the Excel file path with your own in the code.
3.	Run the R script to start the Shiny dashboard.
   
Features
The dashboard offers the following features:
•	Visualizations of labor force data by occupation group and gender.
•	Visualizations of monthly income by education level and gender.
•	Visualizations of employment status by the type of disability.
•	Visualizations of the number of males employed in various industries.
•	Visualizations of the number of females employed in various industries.
•	Visualizations of labor force participation rate by province.
•	Visualizations of employed and unemployed populations by province.


How to Navigate
•	The dashboard allows you to switch between different visualizations using the sidebar.
•	You can interact with the plots and explore data by hovering over data points.

Known Issues
•	If you encounter any issues, please check your R environment for any missing packages or errors in your data source.

Author
•	Eric Duchaine Manishimwe
•	Francios Xavier Jules Mugabushaka

