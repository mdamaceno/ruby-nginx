FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y

# Pacotes necessários
RUN apt-get install -y build-essential
RUN apt-get install -y nano vim wget links curl rsync bc git git-core apt-transport-https libxml2 libxml2-dev libcurl4-openssl-dev openssl sqlite3 libsqlite3-dev
RUN apt-get install -y gawk libreadline6-dev libyaml-dev autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

# Imagemagick
RUN apt-get install -y imagemagick libmagickwand-dev

# Configuração de local do sistema
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Instala RVM, Ruby e Bundler
ENV RUBY_VERSION 2.3.1
RUN /bin/bash -l -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
RUN curl -L  https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/rvm/scripts:/usr/local/rvm/gems/ruby-${RUBY_VERSION}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rvm/rubies/ruby-${RUBY_VERSION}/bin
RUN echo "export GEM_HOME=/usr/local/rvm/gems/ruby-${RUBY_VERSION}" >> /etc/bash.bashrc
RUN echo "export GEM_PATH=/usr/local/rvm/gems/ruby-${RUBY_VERSION}:/usr/local/rvm/gems/ruby-${RUBY_VERSION}@global" >> /etc/bash.bashrc
RUN echo "export PATH=$PATH" >> /etc/bash.bashrc
RUN echo '[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"' >> /etc/bash.bashrc
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install $RUBY_VERSION"
RUN /bin/bash -l -c "rvm use ruby-$RUBY_VERSION"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Instala Passenger com Nginx
# RUN apt-get install -y libcurl4-openssl-dev
# RUN /bin/bash -l -c "gem install passenger --no-ri --no-rdoc"
# RUN /bin/bash -l -c "passenger-install-nginx-module --auto-download --auto"
# RUN /bin/bash -l -c "wget -O init-deb.sh https://gist.github.com/mdamaceno/de2eed3e23f76c853c0b/raw/430f60a6223068c2fcbcaf74f097da461a45c3f7/660-init-deb.sh"
# RUN /bin/bash -l -c "mv init-deb.sh /etc/init.d/nginx"
# RUN /bin/bash -l -c "chmod +x /etc/init.d/nginx"
# RUN /bin/bash -l -c "/usr/sbin/update-rc.d -f nginx defaults"
#
# RUN apt-get clean
#
# RUN /bin/bash -l -c "/bin/bash --login"
# CMD service nginx start
