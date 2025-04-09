FROM ubuntu:24.04 AS root

## for apt to be noninteractive
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        texlive-binaries \
        texlive-metapost \
        texlive-lang-czechslovak \
        texlive-lang-cyrillic \
        libproj25 \
        libfmt9 \
        libshp4 \
        ghostscript \
        imagemagick \
        survex && \
    sed -i '/pattern="PDF"/d' /etc/ImageMagick-6/policy.xml

FROM root AS compiling
RUN \
    apt-get install -y --no-install-recommends \
    cmake \
    g++ \
    pkg-config \
    catch2 libvtk9-dev \
    libproj-dev libshp-dev ninja-build clang-tidy gettext libfmt-dev

COPY ./therion /usr/src/therion/
WORKDIR /usr/src/therion/

RUN \
    mkdir build && cd build && \
    cmake -G Ninja \
      -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchains/gcc.cmake \
      -DCMAKE_C_FLAGS="-Werror" \
      -DCMAKE_CXX_FLAGS="-Werror" \
      -DUSE_BUNDLED_SHAPELIB=OFF \
      -DBUILD_LOCH=OFF \
      -DBUILD_THBOOK=OFF \
      -DBUILD_XTHERION=OFF \
      ..

RUN \
    cmake --build build && \
    cmake --build build -t install

FROM root
COPY --from=compiling /usr/local/bin/therion /usr/local/bin
RUN \
    apt-get clean
ENTRYPOINT ["/usr/local/bin/therion"]
