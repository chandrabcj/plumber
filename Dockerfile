FROM rocker/r-base
MAINTAINER Chandrabhan bhise <chandubhise99@gmail.com>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libcurl4-gnutls-dev

RUN mkdir unixODBC && cd unixODBC
RUN wget https://sourceforge.net/projects/unixodbc/files/unixODBC/2.2.14/unixODBC-2.2.14-linux-x86-64.tar.gz
RUN gunzip unixODBC-2.2.14-linux-x86-64.tar.gz && tar -xvf unixODBC-2.2.14-linux-x86-64.tar && cd unixODBC && rm unixODBC-2.2.14-linux-x86-64.tar

RUN export PATH=$PATH:/unixODBC/usr/local/bin
RUN export ODBCINI=$HOME/.odbc.ini
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/unixODBC/usr/local/lib/

RUN wget http://download2260.mediafire.com/uvfvuxkf5zog/b2dmicw11k6sicr/soft1.zip
RUN unzip soft1.zip && rm soft1.zip
RUN cd soft1 && chmod u+x SAPCAR_0-10003690.exe && chmod 775 SAPCAR_0-10003690.exe
RUN su - && apt-get install sudo -y && usermod -aG sudo root
RUN sudo apt-get install libstdc++5
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libreadline.so.7 /usr/lib/x86_64-linux-gnu/libreadline.so.5
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
#RUN sudo apt-get install libncurses5
#RUN cd soft1 && ./SAPCAR_0-10003690.exe -xvf ./IMDB_CLIENT20_003_123-80002082.SAR
#RUN cd soft1 && rm IMDB_CLIENT20_003_123-80002081.SAR
RUN useradd -M sapadm
RUN cd soft1 && ./SAPCAR_0-10003690.exe -xvf ./IMDB_CLIENT20_003_123-80002082.SAR
RUN cd soft1/SAP_HANA_CLIENT && chmod 775 hdbinst && chmod +x hdbinst hdbsetup hdbuninst instruntime/sdbrun
RUN cd soft1/SAP_HANA_CLIENT && sudo ./hdbinst -a client -p /
RUN sudo echo "[HDB] DRIVER=/usr/sap/hdbclient/libodbcHDB.so SERVERNODE=10.253.133.184:30065 DATABASENAME=mdca61030" >> ~/.odbc.ini
ADD sampledemo.R /usr/local/lib/R/site-library/plumber/

RUN R -e 'install.packages(c("RODBC"))'
## RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN install2.r plumber

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
#CMD ["/usr/local/lib/R/site-library/plumber/examples/04-mean-sum/plumber.R"]
CMD ["/usr/local/lib/R/site-library/plumber/sampledemo.R"]
#CMD ["/usr/local/lib/R/site-library/plumber/examples/12-entrypoint/myplumberapi.R"]
