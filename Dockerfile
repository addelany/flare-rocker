FROM rocker/geospatial:4.3.0

# Import GitHub Secret
ARG GITHUB_PAT
ENV GITHUB_PAT=$GITHUB_PAT

# Declares build arguments
# ARG NB_USER
# ARG NB_UID

# COPY --chown=${NB_USER} . ${HOME}

# USER root
RUN apt-get update && apt-get -y install cron jags libgd-dev

# USER ${NB_USER}

RUN install2.r devtools remotes arrow renv RNetCDF forecast imputeTS ncdf4 scoringRules tidybayes tidync udunits2 bench contentid yaml RCurl here feasts gsheet usethis
RUN R -e "devtools::install_github('cboettig/aws.s3')" && \
    R -e "devtools::install_github('aemon-j/gotmtools', ref = 'yaml')" && \
    R -e "devtools::install_github('eco4cast/read4cast')" && \
    R -e "devtools::install_github('eco4cast/score4cast')" && \
    R -e "devtools::install_github('eco4cast/neon4cast')" && \
    R -e "devtools::install_github('eco4cast/EFIstandards')" && \
    R -e "devtools::install_github('rqthomas/cronR')" && \
    R -e "devtools::install_github('FLARE-forecast/GLM3r', ref = 'glm_3.3.1a2_w_ice_fi')" && \
    R -e "devtools::install_github('rqthomas/glmtools')" && \
    R -e "devtools::install_github('FLARE-forecast/FLAREr')" && \
    R -e "devtools::install_github('FLARE-forecast/GOTMr')" && \
    R -e "devtools::install_github('FLARE-forecast/SimstratR')" && \
    R -e "devtools::install_github('FLARE-forecast/LakeEnsemblR')" && \
    R -e "devtools::install_github('FLARE-forecast/FLARErLER')" && \
    R -e "devtools::install_github('GLEON/rLakeAnalyzer', ref = 'e74974f74082111065bd9cd759527f16608b3c82')"

COPY cron.sh /etc/services.d/cron/run
