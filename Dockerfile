FROM ruby:2.3.1

RUN apt-get update && apt-get upgrade -y

# VIM e Nano
RUN apt-get install -y nano vim

# Imagemagick
RUN apt-get install -y imagemagick libmagickwand-dev

# Instala Passenger com Nginx
RUN apt-get purge -y nginx nginx-full nginx-light nginx-common

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7

RUN /bin/bash -l -c "touch /etc/apt/sources.list.d/passenger.list"
RUN echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main" >> /etc/apt/sources.list.d/passenger.list

RUN apt-get install -y apt-transport-https

RUN apt-get update
RUN apt-get install -y nginx-extras passenger libcurl4-openssl-dev

RUN /bin/bash -l -c "gem install rack --no-ri --no-rdoc"
RUN /bin/bash -l -c "passenger-install-nginx-module --auto-download --auto"
RUN /bin/bash -l -c "wget -O init-deb.sh https://gist.github.com/mdamaceno/de2eed3e23f76c853c0b/raw/430f60a6223068c2fcbcaf74f097da461a45c3f7/660-init-deb.sh"
RUN /bin/bash -l -c "mv init-deb.sh /etc/init.d/nginx"
RUN /bin/bash -l -c "chmod +x /etc/init.d/nginx"
RUN /bin/bash -l -c "/usr/sbin/update-rc.d -f nginx defaults"

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
