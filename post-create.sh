#!/usr/bin/env bash
set -eo pipefail

source /opt/ros/humble/setup.bash
set -u

FRANKA_DESCRIPTION_DIR="/workspace/src/franka_description"
FRANKA_DESCRIPTION_VERSION="1.3.0"
FRANKA_DESCRIPTION_REPO="https://github.com/frankarobotics/franka_description.git"

if [ ! -d "$FRANKA_DESCRIPTION_DIR/.git" ]; then
  git clone --branch "$FRANKA_DESCRIPTION_VERSION" --depth 1 \
    "$FRANKA_DESCRIPTION_REPO" "$FRANKA_DESCRIPTION_DIR"
else
  git -C "$FRANKA_DESCRIPTION_DIR" fetch --tags origin
  git -C "$FRANKA_DESCRIPTION_DIR" checkout "$FRANKA_DESCRIPTION_VERSION"
fi

sudo rosdep install --from-paths src --ignore-src --rosdistro humble -r -y

# The workspace is bind-mounted and may contain stale colcon artifacts from
# another host/container path. Clean once to avoid symlink-install conflicts.
if [ -d /workspace/build ] || [ -d /workspace/install ] || [ -d /workspace/log ]; then
  rm -rf /workspace/build /workspace/install /workspace/log
fi

colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
