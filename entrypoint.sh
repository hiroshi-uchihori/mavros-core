#!/bin/bash
set -e

# ROS 2 環境をソース
source /opt/ros/humble/setup.bash

# IP アドレスを環境変数から取得。指定がなければデフォルト値
GCS_IP=${GCS_IP:-192.168.1.27}
FCU_URL=${FCU_URL:"/dev/ttyACM0:57600"}

# MAVROS 起動
ros2 run mavros mavros_node --ros-args \
   -p fcu_url:=${FCU_URL} \
   -p gcs_url:="udp://0.0.0.0:14551@${GCS_IP}:14550"