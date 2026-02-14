# Setup Distrobox for ROS / ROS 2

[Robot Operating System (ROS)](https://www.ros.org) is highly tied to a specific Ubuntu version. For example, latest ROS 1 release, [Noetic](https://wiki.ros.org/noetic), only officially supports Ubuntu 20.04, while ROS 2 [Humble](https://docs.ros.org/en/humble) only supports Ubuntu 22.04. Even though building ROS from source is an option, we will need to do the same for every dependencies, that can be installed simply with `apt` on officially supported distro.

Instead, we can leverage containerization technology to run ROS on any distro, by using [Distrobox](https://distrobox.it).
