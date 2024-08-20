ARG BASE_APP_IMAGE

FROM ${BASE_APP_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive
# see: https://github.com/AppImage/AppImageKit/wiki/FUSE#docker
ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV QT_QPA_PLATFORM=xcb
ENV RUN_SWAY=true

# Install prereqs
RUN \
    echo "**** Install Prereqs ****" && \
        apt-get update && \
        apt-get install -y \
            ffmpeg \
            gpg-agent \
            libdbus-1-3 \
            libegl1 \
            libglu1-mesa-dev \
            libgstreamer-gl1.0-0 \
            libgtk-3-0 \
            libsdl2-2.0-0 \
            libvulkan1 \
            p7zip-full \
            qt5-qmake \
            qtbase5-dev \
            software-properties-common \
            wget \
            x11-xserver-utils \
            openjdk-17-jre \
            && \
	# Cleanup \
		apt-get autoremove -y && \
		rm -rf /var/lib/apt/lists/*

# Install RetroArch
RUN \
    echo "**** Install RetroArch ****" && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
            gpg-agent \
            libaio-dev \
            libaio1t64 \
            libglu1-mesa \
            libusb-1.0-0 \
            software-properties-common \
            xwayland \
            && \
    # Cleanup \
		apt-get autoremove -y && \
		rm -rf /var/lib/apt/lists/*

ARG PRISM_IMAGE_URL=https://github.com/PrismLauncher/PrismLauncher/releases/latest/download/PrismLauncher-Linux-x86_64.AppImage

ARG APP_IMAGES_FOLDER=/Applications
RUN <<_DOWNLOAD_APP_IMAGES
  #!/bin/bash
  set -e

  echo "**** Downloading Program AppImage(s) ****"
  mkdir -p "${APP_IMAGES_FOLDER}"

  wget -O "${APP_IMAGES_FOLDER}"/prism_launcher.AppImage "${PRISM_IMAGE_URL}"

  chmod -v -R 777 /Applications/
  chmod -v -R a+x /Applications/

  # Cleanup
  apt-get autoremove -y
  rm -rf /var/lib/apt/lists/*
_DOWNLOAD_APP_IMAGES

# Copy script file(s)
COPY --chmod=777 scripts/startup.sh /opt/gow/startup-app.sh

ENV XDG_RUNTIME_DIR=/tmp/.X11-unix

ARG IMAGE_SOURCE
LABEL org.opencontainers.image.source=$IMAGE_SOURCE
