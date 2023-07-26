# docker build --build-arg FFMPEG=0 -t vodrecovery
FROM docker.io/python:3-alpine AS build
RUN apk add --no-cache binutils &&\
      pip install pyinstaller
WORKDIR /tmp/build
COPY . .
RUN pip install -r requirements.txt &&\
      pyinstaller --onefile --name recovervod RecoverVod.py &&\
      sed -i 's/~\/Documents\//\/vods\//g; /UNMUTE_VOD\|CHECK_SEGMENTS/s/false/true/' config/vodrecovery_config.json &&\
      mv config/ dist/

FROM docker.io/alpine
# Use '--build-arg FFMPEG=1' if you want support for downloading M3U8s/VODs as MP4s
ARG FFMPEG
RUN PKGS="catatonit ttyd" &&\
      [ $FFMPEG != 1 ] || PKGS="${PKGS} ffmpeg" &&\
      apk add --no-cache ${PKGS}
WORKDIR /app
COPY --from=build /tmp/build/dist/ .
VOLUME ["/vods"]
EXPOSE 7681/tcp
CMD ["catatonit", "--", "ttyd", "-t", "rendererType=dom", "-t", "disableResizeOverlay=true", "-t", "titleFixed=VodRecovery", "/app/recovervod"]
