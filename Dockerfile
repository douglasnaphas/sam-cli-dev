FROM amazonlinux:2

RUN ["yum", "update", "-y"]
RUN ["yum", "install", "-y", "git"]
RUN curl https://pyenv.run | bash
SHELL ["/usr/bin/bash", "-c"]
ENV PATH /root/.pyenv/bin:$PATH
RUN echo 'if type pyenv &> /dev/null ; then eval "$(pyenv init -)" ; fi' > /root/.bashrc

CMD ["/usr/bin/bash", "-c", "type pyenv"]