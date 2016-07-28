FROM frolvlad/alpine-glibc

ENV CONDA_DIR="/opt/conda"
ENV PATH="$CONDA_DIR/bin:$PATH"

# Install conda
RUN CONDA_VERSION="4.0.5" && \
    CONDA_MD5_CHECKSUM="b1b15a3436bb7de1da3ccc6e08c7a5df" && \
    \
    apk add --no-cache --virtual=.build-dependencies bash && \
    \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    echo "$CONDA_MD5_CHECKSUM  miniconda.sh" | md5sum -c && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    rm miniconda.sh && \
    \
    conda update --all --yes && \
    conda clean --all --yes && \
    echo "Removing older versions of Python due to the bug #3177 in 'conda clean'" && \
    rm -rf $(find /opt/conda/pkgs/ -maxdepth 1 -name python-3\* | sort | head -n -1) && \
    \
    apk del --purge .build-dependencies

RUN echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh
