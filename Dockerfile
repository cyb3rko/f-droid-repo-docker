FROM ubuntu:22.04

RUN apt-get update && \
    echo "Install dependencies..." && \
    apt-get install --no-install-recommends -y curl ca-certificates git python3 python3-pip apksigner openjdk-21-jdk && \
    echo "Fetch latest 'fdroidserver' tag from Gitlab" && \
    version=$(curl -s "https://gitlab.com/api/v4/projects/36527/repository/tags?per_page=1" | sed -E 's/.*"name":"([0-9.a-z]+)".*/\1/') && \
    echo "Clone latest release '$version' from Gitlab" && \
    git clone --depth 1 --branch $version https://gitlab.com/fdroid/fdroidserver.git fdroidserver && \
    echo "Cleanup with apt" && \
    apt-get purge --autoremove -y curl && \
    apt-get autoremove --purge -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN pip install gitpython pyyaml defusedxml asn1crypto ruamel.yaml qrcode requests pillow

WORKDIR /fdroidserver
ARG GIT_PYTHON_REFRESH=quiet
RUN echo "Initializing fdroid" && \
    ./fdroid init -v && \
    ./fdroid update -c

ENTRYPOINT ["bash", "-c"]
CMD ["./fdroid update"]
