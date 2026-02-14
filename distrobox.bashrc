# DO NOT USE THIS FILE FOR YOUR FULL .bashrc
# Instead, use this as a template and copy the relevant sections to your actual .bashrc

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
