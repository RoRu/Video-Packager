Requires:

* Docker

Build:

* docker build . -t "\<image title\>"

Test:

* docker run "\<image title\>" ffmpeg -version
* docker run "\<image title\>" ffmpeg -i https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4

Better use jrottenberg/ffmpeg:4.0-ubuntu image
