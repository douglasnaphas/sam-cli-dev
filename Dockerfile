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
RUN ["yum", "install", "-y", "libffi-devel"]
RUN ["pyenv", "install", "3.7.4"]

CMD ["python", "--version"]