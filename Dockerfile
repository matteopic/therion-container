FROM ubuntu:20.04 AS root

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt update ; \
    apt install -y --no-install-recommends \
		texlive-binaries \
		texlive-metapost \
		libproj15 \
		ghostscript \
		imagemagick \
		survex && \
	sed -i '/pattern="PDF"/d' /etc/ImageMagick-6/policy.xml && \
	rm -rf /var/lib/apt/lists/*

FROM root AS compiling
RUN apt update && \
    apt install -y --no-install-recommends \
		ca-certificates \
		python3 \
		g++ \
		make pkg-config \
		tcl \
		libproj-dev \
		libfmt-dev && \
	rm -rf /var/lib/apt/lists/*

COPY ./therion /usr/src/therion/
WORKDIR /usr/src/therion/
RUN sed -i 's/^LOCHEXE/##LOCHEXE/' /usr/src/therion/Makefile && \
    make config-debian && \
    make ./therion


FROM root
COPY --from=compiling /usr/src/therion/therion /usr/local/bin
RUN rm -rf /var/lib/apt/lists/*
RUN useradd therion
ENTRYPOINT ["/usr/local/bin/therion"]
USER therion