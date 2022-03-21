# CURRENTLY THIS SCRIPTS CANNOT WORK CORRECTLY

Because libc dependency is corrupted.

# jetson_ros2_foxy_docker_no_ml
Jetson Docker Container for ROS2 Foxy with CUDA, CUDNN and TensorRT

This docker container is based on ubuntu20.04.
This container doesn't contain the machine learning libraries like PyTorch. 

## (For Jetson User) Fix nvidia container
please refer this.
https://github.com/dusty-nv/jetson-containers/issues/108

And add  runtime setting for nvidia gpu

/etc/docker/daemon.json
```
{
    "default-runtime": "nvidia", # add this line
    ...
    ...
}
```

## (For Jetson User) Disable nvidia library automount setting
Nvidia container automatically mount host libraries (CUDA, CUDNN and so on).
But sometimes, this function block the updating the software inside container.
So, you should remove or replace the setting file.
please refer this site.
https://github.com/NVIDIA/nvidia-docker/wiki/NVIDIA-Container-Runtime-on-Jetson

please keep only one file l4t.csv.
/etc/nvidia-container-runtime/host-files-for-container.d/l4t.csv

## How to use "launch_container.sh"
 - first time, you have to setup container.

```
./launch_container.sh setup
```

 - after setup, you can access the inside container by same username and hostname is Docker- + Host hostname.
 - next time, you can enter the inside container with only using

```
./launch_container.sh
```
 - if you want to commit the change inside container, please type this command.

```
./launch_container.sh commit
```

## References
https://zenn.dev/marbocub/articles/2fa02378030759
