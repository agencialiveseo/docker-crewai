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

RUN wget https://github.com/coder/code-server/releases/download/v4.18.0/code-server_4.18.0_amd64.deb \
    && dpkg -i code-server_4.18.0_amd64.deb \
    && rm code-server_4.18.0_amd64.deb

RUN sudo -u coder code-server --install-extension ms-python.python
RUN sudo -u coder code-server --install-extension ms-toolsai.jupyter

RUN chown -R coder:coder /app && chmod -R 755 /app

EXPOSE 8080

USER coder

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/app"]
