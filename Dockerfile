FROM rocker/r-base
MAINTAINER Chandrabhan bhise <chandubhise99@gmail.com>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  unixodbc_2.3.6-0.1 \
  libcurl4-gnutls-dev

## RUN R -e 'install.packages(c("devtools"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN install2.r plumber

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/usr/local/lib/R/site-library/plumber/examples/04-mean-sum/plumber.R"]
