[![Docker Stars](https://img.shields.io/docker/stars/frolvlad/alpine-miniconda3.svg?style=flat-square)](https://hub.docker.com/r/frolvlad/alpine-miniconda3/)
[![Docker Pulls](https://img.shields.io/docker/pulls/frolvlad/alpine-miniconda3.svg?style=flat-square)](https://hub.docker.com/r/frolvlad/alpine-miniconda3/)


Miniconda Python 3.5 Docker image
=================================

This image is based on Alpine Linux image, which is only a 5MB image, and contains
[Python 3.5](https://www.python.org/) packaged by Continuum with Conda package manager.

Download size of this image is only:

[![](https://images.microbadger.com/badges/image/frolvlad/alpine-miniconda3.svg)](http://microbadger.com/images/frolvlad/alpine-miniconda3 "Get your own image badge on microbadger.com")

NOTE: Conda repositories contain only Glibc linked packaged binaries for Linux,
so we have to use
[glibc workaround](https://github.com/gliderlabs/docker-alpine/issues/11) on
Alpine.


Usage Example
-------------

```bash
$ docker run --rm frolvlad/alpine-miniconda3 python -c 'print("Hello World")'
```

Once you have run this command you will get printed 'Hello World' from Python!

NOTE: `conda` and `pip` are also available in this image.
