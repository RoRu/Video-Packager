FROM ubuntu:16.04

RUN apt-get -yqq update \
    && apt-get install -yq --no-install-recommends ca-certificates expat libgomp1 \
    && apt-get autoremove -y \
    && apt-get clean -y

ARG PREFIX=/opt/ffmpeg

ENV FFMPEG_VERSION=4.0.2

RUN apt-get install -y libopus-dev \
  libmp3lame-dev \
  libfdk-aac-dev \
  libvpx-dev \
  libx264-dev \
  yasm \
  libass-dev \
  libtheora-dev \
  libvorbis-dev \
  mercurial \
  cmake \
  libx265-dev \
  curl \
  libssl-dev


RUN DIR=$(mktemp -d) && cd ${DIR} && \
    curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
    ./configure \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --enable-gpl \
        --enable-libass \
        --enable-libfdk-aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libtheora \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --enable-nonfree \
        --enable-openssl \
        --enable-small \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" \
        --extra-libs=-ldl \
        --prefix="${PREFIX}" && \
        make && \
        make install && \
        make distclean && \
        hash -r && \
        cd tools && \
        make qt-faststart && \
        cp qt-faststart ${PREFIX}/bin

RUN \
        ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib/ && \
        cp ${PREFIX}/bin/* /usr/local/bin/ && \
        cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ && \
        LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf


ENV LD_LIBRARY_PATH=/usr/local/lib
