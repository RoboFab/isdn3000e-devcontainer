# Usage

This repo now uses the prebuilt Docker Hub image `iamhxx/isdn3000e-ros2-humble-lab10:latest` by default, so students do not need to rebuild the ROS image each time they reopen the devcontainer.

The image reference lives in `.devcontainer/docker/.env` as `DEVCONTAINER_IMAGE`.

# Updating The Image

The source of truth is still `.devcontainer/docker/Dockerfile`.

When you change the Dockerfile, rebuild and push the classroom image with:

```bash
docker build \
  --target base \
  --build-arg UBUNTU_VERSION=22.04 \
  --build-arg WORKSPACE_DIR=/workspace \
  --build-arg USERNAME=developer \
  --build-arg UID=1000 \
  --build-arg GID=1000 \
  -f .devcontainer/docker/Dockerfile \
  -t iamhxx/isdn3000e-ros2-humble-lab10:latest \
  .devcontainer

docker push iamhxx/isdn3000e-ros2-humble-lab10:latest
```

Then reopen the devcontainer so it pulls the updated image.

# Knowledge

Learn more about devcontainers: https://code.visualstudio.com/docs/devcontainers/containers
