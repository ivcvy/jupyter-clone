FROM jupyter/base-notebook

USER root

RUN apt-get update && apt-get install --yes gcc

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt