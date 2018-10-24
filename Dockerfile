FROM rocker/r-base
MAINTAINER Chandrabhan bhise <chandubhise99@gmail.com>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libcurl4-gnutls-dev

RUN mkdir unixODBC && cd unixODBC
RUN wget https://sourceforge.net/projects/unixodbc/files/unixODBC/2.2.14/unixODBC-2.2.14-linux-x86-64.tar.gz
RUN gunzip unixODBC-2.2.14-linux-x86-64.tar.gz
RUN tar -xvf unixODBC-2.2.14-linux-x86-64.tar
RUN cd unixODBC-2.2.14-linux-x86-64
RUN ls

RUN R -e 'install.packages(c("devtools","RODBC"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN install2.r plumber

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/usr/local/lib/R/site-library/plumber/examples/04-mean-sum/plumber.R"]
