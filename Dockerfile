FROM rocker/geospatial:4.2.1

## Declares build arguments
#ARG NB_USER
#ARG NB_UID

#COPY --chown=${NB_USER} . ${HOME}

#USER root
RUN apt-get update && apt-get -y install cron
RUN apt-get update && apt-get -y install jags
RUN apt-get update && apt-get -y install libgd-dev

#USER ${NB_USER}

RUN install2.r devtools remotes
RUN R -e "Sys.setenv("NOT_CRAN" = TRUE); Sys.setenv("LIBARROW_MINIMAL" = FALSE); Sys.setenv("LIBARROW_BINARY" = FALSE); install.packages('arrow')"
RUN R -e "remotes::install_github(c('eco4cast/EFIstandards','cboettig/aws.s3','rqthomas/cronR','eco4cast/score4cast','eco4cast/neon4cast','cboettig/prov', 'eco4cast/read4cast'))"
RUN R -e "remotes::install_github(c('FLARE-forecast/GLM3r','rqthomas/glmtools','rqthomas/FLAREr')"

RUN install2.r renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 bench contentid yaml RCurl here feasts

COPY cron.sh /etc/services.d/cron/run
