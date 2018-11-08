#!/usr/bin/env bash

A=($@)
ffmpeg ${A[@]}
A=(`echo ${A[@]/pass=1/pass=2}`)
A=(`echo ${A[@]/\/dev\/null/transcoded_video_4k.mp4}`)
ffmpeg ${A[@]}
