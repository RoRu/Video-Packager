Required:

* docker
* cwl-runner

Examples of running cwl scripts using tools provided by docker containers.
You may use docker image built from docker-image folder or any public image with ffmpeg.
(There is minor differences between self-created and public images, see comments for more).

Example run:

* cwl-runner ffmpeg_trim.cwl data.yml
* cwl-runner dock_stats.cwl data.yml
