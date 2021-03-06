FROM ubuntu:trusty
MAINTAINER "Syncano DevOps Team" <devops@syncano.com>

ENV LAST_REFRESHED 2016-01-11
ENV export SYNCANO_APIROOT='https://api.syncano.io/'

COPY requirements.txt /tmp/requirements.txt
COPY external_requirements.txt /tmp/external_requirements.txt

RUN apt-get update && apt-get install -qqy \
    git \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    python-dev \
    python-numpy \
    python-scipy \
    wget \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install --upgrade pip \
    && pip install -r /tmp/requirements.txt \
    && pip install -r /tmp/external_requirements.txt

# create a special user to run code
# user without root privileges greatly improves security
RUN useradd syncano -d /tmp -s /bin/bash
RUN chmod 1777 /tmp

USER syncano
CMD ["python"]
