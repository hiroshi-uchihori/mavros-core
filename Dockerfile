FROM ros:humble-ros-core-jammy

# MAVROS をインストール
RUN apt-get update && apt-get install -y \
    ros-humble-mavros \
    ros-humble-mavros-extras \
    geographiclib-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# GeographicLibデータ
RUN geographiclib-get-geoids egm96-5 && \
    geographiclib-get-gravity egm96

# Cyclone DDSのインストール（ただし使わない）
RUN apt-get update && apt-get install -y \
    ros-humble-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

# 環境設定
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# MAVROS の起動用スクリプトを作成
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#MAVROS起動
ENTRYPOINT ["/entrypoint.sh"]