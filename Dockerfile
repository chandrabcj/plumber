FROM rocker/r-base
MAINTAINER Chandrabhan bhise <chandubhise99@gmail.com>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libcurl4-gnutls-dev

RUN mkdir unixODBC && cd unixODBC
RUN wget https://sourceforge.net/projects/unixodbc/files/unixODBC/2.2.14/unixODBC-2.2.14-linux-x86-64.tar.gz
RUN gunzip unixODBC-2.2.14-linux-x86-64.tar.gz
RUN tar -xvf unixODBC-2.2.14-linux-x86-64.tar
RUN cd unixODBC
RUN ls

RUN export PATH=$PATH:/unixODBC/usr/local/bin
RUN export ODBCINI=$HOME/.odbc.ini
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/unixODBC/usr/local/lib/

RUN wget http://download856.mediafire.com/9aim3ua7u98g/u54d05thw1xe7wd/soft1.zip
RUN unzip soft1.zip 
RUN rm soft1.zip
RUN cd soft1 && chmod u+x SAPCAR_0-10003690.exe && chmod 775 SAPCAR_0-10003690.exe
RUN su - && apt-get install sudo -y && usermod -aG sudo root
RUN sudo apt-get install libstdc++5
#RUN sudo apt-get install libncurses5
RUN cd soft1 && ./SAPCAR_0-10003690.exe -xvf ./IMDB_CLIENT20_003_123-80002082.SAR
RUN cd SAP_HANA_CLIENT && chmod +x hdbinst hdbsetup hdbuninst instruntime/sdbrun
RUN sudo ./hdbinst –a client

RUN R -e 'install.packages(c("devtools","RODBC"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN install2.r plumber

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/usr/local/lib/R/site-library/plumber/examples/04-mean-sum/plumber.R"]
