FROM ubuntu:20.04

COPY ./Linux64/Release/HorseServer .

ENTRYPOINT ./HorseServer