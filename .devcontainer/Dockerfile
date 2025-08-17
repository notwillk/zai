ARG VARIANT="alpine-3.21"

FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

ARG PNPM_HOME="/global/pnpm"

RUN mkdir -p ${PNPM_HOME}

ENV PNPM_HOME="${PNPM_HOME}"
ENV PATH="$PATH:/workspaces/zai/repo/scripts:${PNPM_HOME}"

COPY .devcontainer/tools/install.sh .devcontainer/tools/tools.json /tmp/
RUN /tmp/install.sh && rm /tmp/install.sh /tmp/tools.json
