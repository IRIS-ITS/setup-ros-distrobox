# Setup Distrobox for ROS / ROS 2

[Robot Operating System (ROS)](https://www.ros.org) is highly tied to a specific Ubuntu version. For example, latest ROS 1 release, [Noetic](https://wiki.ros.org/noetic), only officially supports Ubuntu 20.04, while ROS 2 [Humble](https://docs.ros.org/en/humble) only supports Ubuntu 22.04. Even though building ROS from source is an option, we will need to do the same for every dependencies, that can be installed simply with `apt` on officially supported distro.

Instead, we can leverage containerization technology to run ROS on any distro, by using [Distrobox](https://distrobox.it).

# What is Distrobox?

[Distrobox](https://distrobox.it) is a tool that allows you to create and manage containerized environments using Podman or Docker. It provides a simple interface to create and manage containers, making it easy to run applications in isolated environments. Distrobox is designed to be lightweight and seamlessly integrate with your host system, allowing you to access files and devices from within the container.

# Installation

## Install Distrobox

> This guide uses Ubuntu as an example.

To install Distrobox, you can follow the instructions on the [official Distrobox website](https://distrobox.it/#installation). The installation process may vary depending on your Linux distribution, but generally involves installing the Distrobox package and its dependencies. It's recommended to use Podman as the container runtime for better performance and rootless containers.

```bash
sudo apt install -y curl podman
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
```

![Inside a Distrobox container](https://github.com/IRIS-ITS/setup-ros-distrobox/raw/main/distrobox.png)

## Create a Distrobox Container

Once you have Distrobox installed, you can create a container for ROS.

For example,

```bash
distrobox create --name ros1 --image docker.io/osrf/ros:noetic-desktop-full

distrobox enter ros1
```

## Setting Up `.bashrc`

To make it easier to enter the Distrobox container, you can add a function to your [`.bashrc`](https://github.com/IRIS-ITS/setup-ros-distrobox/blob/main/distrobox.bashrc) file. This function will allow you to enter the container with a simple command, as well as set up the necessary environment variables for ROS.

```bash
cat << 'EOF' >> ~/.bashrc
alias ros1="distrobox enter ros1"

# Distrobox setup
if [ -n "$DISTROBOX_ENTER_PATH" ] || [ -n "$ON_DISTROBOX" ]; then

    # Disable MIT-SHM for Qt applications to avoid issues with shared memory in containers
    export QT_X11_NO_MITSHM=1

    # Force display to the host's actual display
    HOST_DISPLAY=$(distrobox-host-exec printenv DISPLAY 2>/dev/null)
    if [ -n "$HOST_DISPLAY" ]; then
        export DISPLAY="$HOST_DISPLAY"
    fi

    # Check if specifically inside the 'ros1' container
    if [[ "$CONTAINER_ID" == "ros1" ]]; then
        source /opt/ros/noetic/setup.bash

        # Set a custom prompt so we know we're in ROS
        export PS1="(ROS 1) $PS1"
    fi
fi
EOF
```
