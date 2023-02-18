FROM rocker/geospatial:4.2.1

# Import GitHub Secret
RUN --mount=type=secret,id=GIT_ACCESS_TOKEN \
    cat /run/secrets/GIT_ACCESS_TOKEN
    
## Declares build arguments
#ARG NB_USER
#ARG NB_UID

#COPY --chown=${NB_USER} . ${HOME}

#USER root
RUN apt-get update && apt-get -y install cron
RUN apt-get update && apt-get -y install jags
RUN apt-get update && apt-get -y install libgd-dev

#USER ${NB_USER}

RUN install2.r devtools remotes arrow renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 bench contentid yaml RCurl here feasts gsheet usethis
RUN R -e "remotes::install_github(c('eco4cast/EFIstandards','rqthomas/cronR','eco4cast/neon4cast','cboettig/prov'))" #'cboettig/aws.s3'
RUN R -e "remotes::install_github(c('FLARE-forecast/GLM3r','rqthomas/glmtools','FLARE-forecast/FLAREr'))"
#RUN R -e "remotes::install_github('GLEON/rLakeAnalyzer', ref = 'e74974f74082111065bd9cd759527f16608b3c82')"
RUN R -e "remotes::install_github('aemon-j/gotmtools', ref = 'yaml', auth_token = ${id})"
#RUN R -e "remotes::install_github(c('FLARE-forecast/GOTMr','FLARE-forecast/SimstratR','FLARE-forecast/LakeEnsemblR','FLARE-forecast/FLARErLER'), auth_token = ${GIT_ACCESS_TOKEN})"

COPY cron.sh /etc/services.d/cron/run
