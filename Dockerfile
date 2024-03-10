FROM ubuntu:latest
ARG UID=1000
ARG GID=1000

RUN	apt-get update \
    && apt-get install -y sudo \
    && addgroup --gid $GID nonroot \
    && adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot \
    && echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
	&& apt-get -y install curl \
	&& apt-get -y install gpg \
	&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
	&& echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
	&& apt-get update \
	&& apt-get -y install nodejs \
	&& npm install -g typescript \
	&& npm install -g lite-server \
	&& npm install -g jest \
	&& npm install -g ts-jest \
	&& npm install -g @types/jest \
	&& npm install -g ts-node

USER nonroot
WORKDIR /home/nonroot/app