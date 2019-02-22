FROM bioconductor/devel_base2

ADD ./install.sh /tmp/
RUN chmod 755 /tmp/install.sh
RUN /tmp/install.sh
RUN R -e "BiocManager::install('variants', version = '3.9', update=TRUE, ask=FALSE)";
