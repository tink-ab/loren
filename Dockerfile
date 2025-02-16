FROM 784217881480.dkr.ecr.eu-west-1.amazonaws.com/tink-containers/python-debian:3.7-buster

# Set up locales
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

COPY . /tmp/loren

RUN set -ex \
 && python -m pip install -r /tmp/loren/requirements.txt \
 && python -m pip install /tmp/loren \
 && python -m pip install pytest \
 && pytest 
 && rm -rf /tmp/