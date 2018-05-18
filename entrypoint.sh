#!/bin/bash

cd /DockerData/GIT/AutoShorStation ; git pull
Rscript /DockerData/GIT/AutoShoreStation/pH/GetConvertedpHData.R
cd /DockerData/GIT/Agua-Hedionda ; git pull
Rscript /DockerData/GIT/Agua-Hedionda/ScrapeGoogleSheet.R
