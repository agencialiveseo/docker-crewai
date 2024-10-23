FROM liveseo/crewai

WORKDIR /app

RUN apt-get update

RUN apt-get install -y \
  curl \
  git \
  sudo \
  wget \
  build-essential \
  libssl-dev \
  libffi-dev \
  python3-dev

RUN rm -rf /var/lib/apt/lists/*

ARG USER_ID=1000  # Ajuste para o UID do seu usuário no host
ARG GROUP_ID=1000 # Ajuste para o GID do seu usuário no host

RUN groupadd -g ${GROUP_ID} coder
RUN useradd -m -u ${USER_ID} -g coder -s /bin/bash coder

RUN echo 'export PATH=$PATH:/home/coder/.local/bin' >> /home/coder/.bashrc
RUN echo 'coder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -qO- https://api.github.com/repos/coder/code-server/releases/latest \
  | grep "browser_download_url.*code-server_.*_amd64.deb" \
  | cut -d '"' -f 4 \
  | wget -qi - \
  && dpkg -i code-server*.deb \
  && rm code-server*.deb

RUN chown -R coder:coder /app && chmod -R 755 /app

USER coder

RUN mkdir /app/.vscode
COPY .vscode/* /app/.vscode

RUN code-server --install-extension ms-python.python
RUN code-server --install-extension ms-python.debugpy
RUN code-server --install-extension ms-toolsai.jupyter
RUN code-server --install-extension ms-toolsai.jupyter-renderers 

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/app"]