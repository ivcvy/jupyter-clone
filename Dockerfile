FROM jupyter/base-notebook

USER root

RUN apt-get update && \
    apt-get -y install sudo

RUN adduser --disabled-password --gecos "" jupyter-clone && \
    echo "jupyter-clone:breadcrumb" | chpasswd && \
    usermod -aG sudo jupyter-clone &&\
    echo "jupyter-clone ALL=(ALL) ALL" > /etc/sudoers.d/jupyter-clone && \
    chown -R jupyter-clone:jupyter-clone /home/jovyan

USER jupyter-clone

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt