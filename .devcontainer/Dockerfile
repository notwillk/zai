ARG VARIANT="alpine-3.21"

FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

ARG PNPM_HOME="/global/pnpm"

RUN mkdir -p ${PNPM_HOME}

ENV PNPM_HOME="${PNPM_HOME}"
ENV PATH="$PATH:/workspaces/zai/repo/scripts:${PNPM_HOME}"

COPY repo/toolbox/install.sh repo/toolbox/tools.json /tmp/

RUN /tmp/install.sh
