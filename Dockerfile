FROM python:2.7.9

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD requirements.txt /usr/src/app/
RUN pip install -r requirements.txt

ADD src/universal /usr/src/app
ADD etc/ssh/ssh_config /etc/ssh/ssh_config