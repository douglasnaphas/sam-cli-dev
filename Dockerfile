FROM amazonlinux:2

RUN ["yum", "install", "-y", "git"]
RUN curl https://pyenv.run | bash

CMD ["git", "--version"]