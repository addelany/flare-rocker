FROM rocker/geospatial:4.3.2

# Import GitHub Secret
# ARG GITHUB_PAT
# ENV GITHUB_PAT=$GITHUB_PAT

# Declares build arguments
# ARG NB_USER
# ARG NB_UID

# COPY --chown=${NB_USER} . ${HOME}

# USER root
RUN apt-get update && apt-get -y install cron jags libgd-dev

# USER ${NB_USER}

RUN install2.r devtools remotes arrow renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 RcppRoll
RUN install2.r bench contentid yaml RCurl here feasts gsheet usethis tidymodels xgboost rMR
RUN R -e "devtools::install_github('cboettig/aws.s3')"
RUN sleep 180
RUN R -e "devtools::install_github('aemon-j/gotmtools', ref = 'yaml')"
RUN sleep 180
RUN R -e "devtools::install_github('eco4cast/read4cast')"
RUN sleep 180
RUN R -e "devtools::install_github('eco4cast/score4cast')"
RUN sleep 180
RUN R -e "devtools::install_github('eco4cast/neon4cast')"
RUN sleep 180
RUN R -e "devtools::install_github('eco4cast/EFIstandards')"
RUN sleep 180
RUN R -e "devtools::install_github('rqthomas/cronR')"
RUN sleep 180
RUN R -e "devtools::install_github('rqthomas/glmtools')"
RUN sleep 180
RUN R -e "devtools::install_github('FLARE-forecast/FLAREr')"
#RUN sleep 180
#RUN R -e "devtools::install_github('FLARE-forecast/GOTMr')"
#RUN sleep 180
#RUN R -e "devtools::install_github('FLARE-forecast/SimstratR')"
#RUN sleep 180
#RUN R -e "devtools::install_github('FLARE-forecast/LakeEnsemblR')"
#RUN sleep 180
#RUN R -e "devtools::install_github('FLARE-forecast/FLARErLER')"
#RUN sleep 180
#RUN R -e "devtools::install_github('GLEON/rLakeAnalyzer', ref = 'e74974f74082111065bd9cd759527f16608b3c82')"
#RUN sleep 180
#RUN R -e "devtools::install_github('FLARE-forecast/GLM3r')" 

RUN apt-get install libmagick++-dev

COPY cron.sh /etc/services.d/cron/run
