ARG UID=100
ARG VERSION=0.92.2

FROM buildpack-deps:focal-curl AS downloader

ARG VERSION

RUN curl -sSLo /tmp/hugo.deb "https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_extended_${VERSION}_Linux-64bit.deb"

FROM ubuntu:focal

COPY --from=downloader /tmp/hugo.deb /tmp/hugo.deb

RUN dpkg -i /tmp/hugo.deb \
 && rm -rf /tmp/hugo.deb

ARG UID
RUN groupadd hugo \
 && useradd -g ${UID} -l -m -s /bin/false -u 1000 hugo

USER hugo

WORKDIR ${HOME}
