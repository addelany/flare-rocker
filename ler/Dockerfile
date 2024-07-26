FROM rocker/geospatial:4.2.2

## Declares build arguments
#ARG NB_USER
#ARG NB_UID

#COPY --chown=${NB_USER} . ${HOME}

#USER root
RUN apt-get update && apt-get -y install cron jags libgd-dev

RUN install2.r devtools remotes renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 RcppRoll
RUN R -e "remotes::install_github(c('eco4cast/EFIstandards','cboettig/aws.s3','rqthomas/cronR','eco4cast/score4cast','eco4cast/neon4cast','cboettig/prov', 'eco4cast/read4cast'))"
RUN sleep 180
RUN R -e "install.packages('arrow', repos = 'https://packagemanager.rstudio.com/all/__linux__/jammy/latest')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/GLM3r', ref = 'c692b700b833d5022031d3cde7bb50ffa09ab78e')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/GOTMr', ref = 'c7c7ed3d8259325a86be5ba2ea9c7e403d17c7ab')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/SimstratR', ref = 'c6ccb997705f700f6ff6cf4c3d5c139a69c638bf')"
RUN sleep 180
RUN R -e "remotes::install_github('aemon-j/gotmtools', ref = 'yaml')"
RUN sleep 180
RUN R -e "remotes::install_github('rqthomas/glmtools', ref = 'b50e9a7b73e41afcd8119e2b9ac172c1c7beb51f')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/LakeEnsemblR', ref = 'b2927e22767a59ae46d709c91e3e8b87d5a6bf84')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/FLAREr', ref = '3a6d71be4444ff1c427c3aa72966439e77a7628a')"
RUN sleep 180
RUN R -e "remotes::install_github('FLARE-forecast/FLARErLER', ref = '2d8db70545c0ac17d7ea2086824f946567e4ea75')"

RUN install2.r tidyverse renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 bench contentid yaml RCurl here feasts gsheet

COPY cron.sh /etc/services.d/cron/run
