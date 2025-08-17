ARG VARIANT="alpine-3.21"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

ARG version
# COPY repo/toolbox/tools.json .

ENV PATH="$PATH:/workspaces/zai/repo/scripts"

COPY repo/toolbox/install.sh repo/toolbox/tools.json /tmp/
RUN /tmp/install.sh
