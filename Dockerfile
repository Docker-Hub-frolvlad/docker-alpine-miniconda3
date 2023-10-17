FROM frolvlad/alpine-glibc:alpine-3.18

ARG CONDA_VERSION="py311_23.5.2-0"
ARG CONDA_SHA256="634d76df5e489c44ade4085552b97bebc786d49245ed1a830022b0b406de5817"
ARG CONDA_DIR="/opt/conda"

ENV PATH="$CONDA_DIR/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1

# Install conda
RUN echo "**** install dev packages ****" && \
    apk add --no-cache --virtual .build-dependencies bash ca-certificates wget && \
    \
    echo "**** get Miniconda ****" && \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "$CONDA_SHA256  miniconda.sh" | sha256sum -c && \
    \
    echo "**** install Miniconda ****" && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    \
    echo "**** setup Miniconda ****" && \
    conda update --all --yes && \
    conda config --set auto_update_conda False && \
    \
    echo "**** cleanup ****" && \
    apk del --purge .build-dependencies && \
    rm -f miniconda.sh && \
    conda clean --all --force-pkgs-dirs --yes && \
    find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    \
    echo "**** finalize ****" && \
    mkdir -p "$CONDA_DIR/locks" && \
    chmod 777 "$CONDA_DIR/locks"
