FROM ros:melodic-perception

# Install ros-bridge package
RUN apt-get update -y && \
    apt-get install ros-melodic-rosbridge-suite -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installation of Gazebo 9
# setup timezone
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# setup sources.list
RUN . /etc/os-release \
    && echo "deb http://packages.osrfoundation.org/gazebo/$ID-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-latest.list

# install gazebo packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gazebo9=9.16.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get update && apt-get install -y \
    ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control \
    && rm -rf /var/lib/apt/lists/*

COPY ./docker_entrypoint.sh /
COPY ./gazebo_envs /

VOLUME [ "/tmp/.X11-unix" ]
VOLUME [ "/dev/dri" ]

EXPOSE 11311
EXPOSE 11345
EXPOSE 9090

# ENTRYPOINT [ "/docker_entrypoint.sh" ]

# CMD [ "roslaunch", "rosbridge_server", "rosbridge_websocket.launch" ]