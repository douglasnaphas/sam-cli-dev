FROM amazonlinux:2

ARG GIT_NAMESPACE=awslabs
ARG GIT_REPO=aws-sam-cli
ARG GIT_BRANCH=develop
SHELL ["/usr/bin/bash", "-c"]
ENV PATH /root/.pyenv/bin:$PATH
RUN yum update -y && \
  yum install -y git \
  tar \
  gcc \
  make \
  zlib \
  openssl-devel \
  libffi-devel \
  which && \
  curl https://pyenv.run | bash && \
  echo 'if type pyenv &> /dev/null ; then eval "$(pyenv init -)" ; fi' > /root/.bashrc && \
  pyenv install 3.7.4 && \
  . ~/.bashrc && \
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

CMD . /root/.bashrc && \
  . venv3.7.4/bin/activate && \
  echo "profile: " ${AWS_PROFILE:-default} && \
  echo "template: " ${TEMPLATE_YML:-template.yml} && \
  echo "port: " ${PORT:-4401} && \
  ls /tmp/host-cwd
# head template.yml
# samdev local start-api 