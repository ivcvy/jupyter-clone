FROM quay.io/jupyter/base-notebook

USER root

RUN apt-get update && \
    apt-get -y install sudo

RUN echo "jovyan:breadcrumb" | chpasswd && \
    usermod -aG sudo jovyan &&\
    echo "jovyan ALL=(ALL) ALL" > /etc/sudoers.d/jovyan && \
    chown -R jovyan: /home/jovyan

USER jovyan

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

WORKDIR /home/jovyan