FROM debian:latest

RUN sudo apt update && apt upgrade -y
RUN sudo apt install git python3-pip ffmpeg -y

RUN mkdir /safone/
WORKDIR /safone/
COPY . /safone/

RUN sudo pip3 install --upgrade pip
RUN sudo pip3 install -U -r requirements.txt

CMD python3 main.py
