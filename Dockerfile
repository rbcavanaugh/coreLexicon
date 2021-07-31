# File: Dockerfile
FROM rocker/shiny-verse:latest

RUN apt-get update -qq \
  && apt-get -y --no-install-recommends install \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
  && install2.r --error --deps TRUE \
    shinyWidgets \
    here \
    shinyjs \
    bslib \
    tokenizers \
    textstem \
    tidytext \
    shinipsum \
    DT \
    scales \
    patchwork \
    waiter \
    truncnorm
    
# Copy configuration files into the Docker image
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /app /srv/shiny-server/
RUN rm /srv/shiny-server/index.html
# Make the ShinyApp available at port 80
EXPOSE 80
# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
CMD ["/usr/bin/shiny-server.sh"]