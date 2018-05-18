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
RUN apt-get -y install libssl-dev
RUN apt-get -y install r-cran-rjava

RUN Rscript -e 'install.packages("lubridate")'
RUN Rscript -e 'install.packages("googleAuthR")'
RUN Rscript -e 'install.packages("googledrive")'
RUN Rscript -e 'install.packages("ncdf4")'
RUN Rscript -e 'install.packages("xlsx")'


#ENTRYPOINT exec /DockerData/GIT/docker-rstudio/entrypoint.sh
CMD /bin/bash

#
# Useful commands
#
#  docker build -t sccoos-rstudio:02 .
#  docker run -i -t --rm --name sccoos-rstudio-v02 sccoos-rstudio:02
#
#  v02:  image builds with Rscript running R scripts as an entrypoint, making running the container a daily cron job
#  v01:  image builds with cron jobs internal to container

#  docker run -i -t --rm -v /Users/vrowley/GIT/AutoShoreStation:/home/jfumo/AutoShoreStation --cap-add=SYS_ADMIN --name sass-nb-ph rocker/r-base bash
#  docker run -i -t --rm -v /Users/vrowley/GIT/AutoShoreStation:/home/jfumo/AutoShoreStation --cap-add=SYS_ADMIN --name sass-nb-phv01 sass-nb-ph:02 bash
# 
# To run the script from the command line:  Rscript <scriptname>
#
#
