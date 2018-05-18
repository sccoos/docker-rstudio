# Sample Dockerfile to customize rocker/rstudio image to include things needed to run:
# NB SASS pH computations daily
# NB SASS O2 computations daily
# SeaphOx computations daily

# First start with the latest image
FROM rocker/rstudio

# install librariis needed by R packages that will be installed
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install apt-utils
RUN apt-get update
RUN echo "deb https://deb.debian.org/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list
RUN apt-get install apt-transport-https
RUN apt-get -y install cron
RUN apt-get -y install libnetcdf-dev
RUN apt-get -y install r-cran-rjava

RUN Rscript -e 'install.packages("lubridate")'
RUN Rscript -e 'install.packages("googledrive")'
RUN Rscript -e 'install.packages("ncdf4")'
RUN Rscript -e 'install.packages("xlsx")'

# Grab code that needs to be run from GIT
RUN git clone https://github.com/jfumo/AutoShoreStation.git
Run git clone https://github.com/SUPScientist/Agua-Hedionda.git

#
# Put command to run R script into /etc/cron.daily
# Put command to run R script into /etc/cron.d/Get\ Converted\ pH\ Data.R
#
RUN echo "*/5 * * * * Rscript /DockerData/GIT/AutoShoreStation/pH/GetConvertedpHData.R" > /etc/cron.daily/NB-pH
RUN echo "*/5 * * * * Rscript /DockerData/GIT/Agua-Hedionda/ScrapeGoogleSheet.R" > /etc/cron.daily/SeapHOx
RUN /etc/init.d/cron reload

#
# Useful commands
#
#  docker build -t sccoos-rstudio:01 .
#  docker run -i -t --rm /v --name sccoos-rstudio-v01 rocker/r-base bash

#  docker run -i -t --rm -v /Users/vrowley/GIT/AutoShoreStation:/home/jfumo/AutoShoreStation --cap-add=SYS_ADMIN --name sass-nb-ph rocker/r-base bash
#  docker run -i -t --rm -v /Users/vrowley/GIT/AutoShoreStation:/home/jfumo/AutoShoreStation --cap-add=SYS_ADMIN --name sass-nb-phv01 sass-nb-ph:02 bash
# 
# To run the script from the command line:  Rscript <scriptname>
#
#
