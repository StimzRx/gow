# ABeltramo/retroarch-docker

Running [RetroArch](https://www.retroarch.com/) on Docker with [Sunshine](https://github.com/loki-47-6F-64/sunshine) so that you can connect to it using [Moonlight](https://moonlight-stream.org/) on any supported client.

![Screenshot of DOOM](screen/DOOM.png)

## Quickstart

```console
docker run -it --rm \
    --name retroarch \
    -p 47984-47990:47984-47990/tcp \
    -p 48010:48010 \
    -p 48010:48010/udp \
    -p 47998-48000:47998-48000/udp \
    --volume ~/retroarch:/retroarch/ \
    --device /dev/uinput \
    --env RESOLUTION=1920x1080x24 \
    --env LOG_LEVEL=INFO \
    abeltramo/retroarch
```

Connect over Moonlight by manually adding the IP address of the PC running the Docker container. To validate the PIN you can use the Sunshine web interface (at `https://<IP>:47990/` username: sunshine password is auto generated on startup check the docker logs.) or directly calling: `curl <IP>:47989/pin/<PIN>`.

From Moonlight start RetroArch, you should be able to see the main UI:

![Screenshot of RetroArch UI](screen/RetroArch-First-UI.png)


## RetroArch first time configuration

> Using the keyboard you can move using the arrows and get back to the previous menu by pressing backspace

From the **Main Menu** > **Online Updater** select:
- Update Core Info Files
- Update assets

Get back to **Settings** > **Video** > **Fullscreen Mode** set **Start in Fullscreen Mode** to **ON**

This should make the window take the full screen, giving you a nice result like:

![Screenshot of RetroArch UI](screen/RetroArch-UI.png)

## Host troubleshooting

Make sure that /dev/uinput have the correct permissions.
Try following this: https://github.com/chrippa/ds4drv/issues/93#issuecomment-265300511
(On Debian I had to modify `/etc/modules-load.d/modules.conf`, adding `/etc/modules-load.d/uinput.conf` didn't trigger anything to me)
```console
ls -la /dev/uinput
crw-rw---- 1 $USER input 10, 223 Jun  9 08:57 /dev/uinput # Check that $USER is not root but your current user
```
Non permanent fix:
```console
sudo chmod 0660 /dev/uinput
```

## Docker build

You can either build the docker image or use the pre-built one available at [DockerHub](https://hub.docker.com/r/abeltramo/retroarch).

To build it locally run:

```console
sudo docker build -t abeltramo/retroarch .
```
