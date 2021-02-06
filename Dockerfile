FROM danielrs975/ros-melodic-gazebo

# Copy the simulation files into the image
COPY ./gazebo_envs /

CMD roslaunch rosbridge_server rosbridge_websocket.launch & \
    rosrun gazebo_ros gzserver Teresa_Lightweight.world