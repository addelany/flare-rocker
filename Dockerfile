FROM rocker/geospatial:4.2.1

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
RUN R -e "install.packages('gh')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('cboettig/aws.s3', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('aemon-j/gotmtools', ref = 'yaml', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('eco4cast/read4cast', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('eco4cast/score4cast', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('eco4cast/neon4cast', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('eco4cast/EFIstandards', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('rqthomas/cronR', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/GLM3r', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('rqthomas/glmtools', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/FLAREr', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/GOTMr', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/SimstratR', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/LakeEnsemblR', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('FLARE-forecast/FLARErLER', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')" && \
    R -e "devtools::install_github('GLEON/rLakeAnalyzer', ref = 'e74974f74082111065bd9cd759527f16608b3c82', auth_token ='$GITHUB_PAT')" && \
    R -e "gh::gh_rate_limit(.token = '$GITHUB_PAT')"

COPY cron.sh /etc/services.d/cron/run

