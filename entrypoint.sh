#!/bin/bash

Rscript -e 'install.packages("lubridate")'
Rscript -e 'install.packages("googleAuthR")'
Rscript -e 'install.packages("googledrive")'
Rscript -e 'install.packages("ncdf4")'
Rscript -e 'install.packages("xlsx")'

cd /DockerData/GIT/AutoShorStation ; git pull
Rscript /DockerData/GIT/AutoShoreStation/pH/GetConvertedpHData.R
cd /DockerData/GIT/Agua-Hedionda ; git pull
Rscript /DockerData/GIT/Agua-Hedionda/ScrapeGoogleSheet.R
