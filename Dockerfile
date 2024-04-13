FROM python:3.8.5

RUN apt-get update -y && apt-get upgrade -y

# Install ffmpeg and av (audio/video) encoding (for av to be build/installed)
RUN apt-get install -y ffmpeg libavformat-dev \
    libavcodec-dev libavdevice-dev libavutil-dev \
    libswscale-dev libavresample-dev libavfilter-dev libopenmpi-dev
# Clean cache
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /safone

# copy the .env vars and requirements
COPY requirements.txt ./
# install those deps
RUN pip install -r requirements.txt

# Copy the project essentials components to ./safone
# files
COPY *.py app.json ./
# directories
COPY plugins/ ./plugins/
COPY helpers/ ./helpers/
COPY assets/ ./assets/

# Set env vars
COPY .env ./
RUN . /safone/.env
# execute the script
CMD ["python", "main.py"]
