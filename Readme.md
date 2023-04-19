# Using this in another docker image:

```
FROM ubuntu:focal

WORKDIR /ffmpeg-temp

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update\
    && apt-get -y install\
        wget\
        make\
        autoconf \
        automake \
        build-essential \
        cmake\
        python3\
        libass\
        libfreetype6\
        libgnutls28\
        libmp3lame\
        libsdl2\
        libtool \
        libva\
        libvdpau\
        libvorbis\
        libxcb1\
        libxcb-shm0\
        libxcb-xfixes0\
        zlib1g

ADD ./ffmpeg-libs/* /usr/local/lib/

ADD ./ffmpeg-headers/libavcodec /usr/local/include/libavcodec
ADD ./ffmpeg-headers/libavdevice /usr/local/include/libavdevice
ADD ./ffmpeg-headers/libavfilter /usr/local/include/libavfilter
ADD ./ffmpeg-headers/libavformat /usr/local/include/libavformat
ADD ./ffmpeg-headers/libavutil /usr/local/include/libavutil
ADD ./ffmpeg-headers/libpostproc /usr/local/include/libpostproc
ADD ./ffmpeg-headers/libswresample /usr/local/include/libswresample
ADD ./ffmpeg-headers/libswscale /usr/local/include/libswscale

RUN ln -s /usr/local/lib/libavcodec.so.* /usr/local/lib/libavcodec.so\
    && ln -s /usr/local/lib/libavformat.so.* /usr/local/lib/libavformat.so\
    && ln -s /usr/local/lib/libavdevice.so.* /usr/local/lib/libavdevice.so\
    && ln -s /usr/local/lib/libavfilter.so.* /usr/local/lib/libavfilter.so\
    && ln -s /usr/local/lib/libavutil.so.* /usr/local/lib/libavutil.so\
    && ln -s /usr/local/lib/libpostproc.so.* /usr/local/lib/libpostproc.so\
    && ln -s /usr/local/lib/libswresample.so.* /usr/local/lib/libswresample.so\
    && ln -s /usr/local/lib/libswscale.so.* /usr/local/lib/libswscale.so

RUN ldconfig /usr/local/lib/

ENV CXX_FLAGS="-I/usr/local/include/"
```
