FROM rocker/geospatial:4.2.1

# Import GitHub Secret
RUN --mount=type=secret,id=GIT_ACCESS_TOKEN \
    cat /run/secrets/GIT_ACCESS_TOKEN
    
ENV GITHUB_PAT=${id}
    
## Declares build arguments
#ARG NB_USER
#ARG NB_UID

#COPY --chown=${NB_USER} . ${HOME}

#USER root
RUN apt-get update && apt-get -y install cron
RUN apt-get update && apt-get -y install jags
RUN apt-get update && apt-get -y install libgd-dev

#USER ${NB_USER}

#Run R -e "Sys.setenv(GITHUB_PAT = $GITHUB_TOKEN)"
Run R -e "Sys.getenv()"

RUN install2.r devtools remotes arrow renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 bench contentid yaml RCurl here feasts gsheet usethis
RUN R -e "remotes::install_github(c('eco4cast/EFIstandards','rqthomas/cronR','eco4cast/neon4cast','cboettig/prov'), auth_token = ${id})" #'cboettig/aws.s3'
RUN R -e "remotes::install_github(c('FLARE-forecast/GLM3r','rqthomas/glmtools','FLARE-forecast/FLAREr'), auth_token = ${id})"
#RUN R -e "remotes::install_github('GLEON/rLakeAnalyzer', ref = 'e74974f74082111065bd9cd759527f16608b3c82',auth_token = ${id})"
#RUN R -e "remotes::install_github('aemon-j/gotmtools', ref = 'yaml', auth_token = ${id})"
#RUN R -e "remotes::install_github(c('FLARE-forecast/GOTMr','FLARE-forecast/SimstratR','FLARE-forecast/LakeEnsemblR','FLARE-forecast/FLARErLER'), auth_token = ${id})"

COPY cron.sh /etc/services.d/cron/run
