FROM amazonlinux:2

SHELL ["/usr/bin/bash", "-c"]
ENV PATH /root/.pyenv/bin:$PATH
RUN ["yum", "update", "-y"]
RUN ["yum", "install", "-y", "git", "tar"]
RUN curl https://pyenv.run | bash
RUN echo 'if type pyenv &> /dev/null ; then eval "$(pyenv init -)" ; fi' > /root/.bashrc
RUN ["yum", "install", "-y", "gcc"]
RUN ["yum", "install", "-y", "make"]
RUN ["yum", "install", "-y", "zlib"]
RUN ["yum", "install", "-y", "openssl-devel"]
RUN ["yum", "install", "-y", "libffi-devel", "which"]
RUN ["pyenv", "install", "3.7.4"]
ARG GIT_NAMESPACE=awslabs
ARG GIT_REPO=aws-sam-cli
ARG GIT_BRANCH=develop
RUN . ~/.bashrc && \
  pyenv shell 3.7.4 && \
  pip install --upgrade pip  && \
  pip install virtualenv && \
  type python && \
  python --version && \
  pyenv global 3.7.4 && \
  pyenv local 3.7.4 && \
  virtualenv --python=$(which python) venv3.7.4 && \
  . venv3.7.4/bin/activate && \
  git clone https://github.com/${GIT_NAMESPACE}/${GIT_REPO}.git && \
  cd ${GIT_REPO} && \
  git checkout ${GIT_BRANCH} && \
  make init

CMD . /root/.bashrc && . venv3.7.4/bin/activate && python --version && which samdev