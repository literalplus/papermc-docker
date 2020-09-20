# PaperMC Docker
This is a Linux Docker image for the PaperMC Minecraft server, modified
to work with a Kubernetes setup.

This fork is optimised for usage in Kubernetes. It requires the following
setup to be done by Kubernetes (perferably a stateful set):
 * A persistent volume mounted at /data/worlds/
 * server.properties (ConfigMap) needs to have:
   * `level-name=/data/worlds/this-last-part-is-arbitrary` (world storage location)
   * `enable-rcon=true` (so you can issue console commands)
   * `rcon.password=XXX` (must match the RCON_PW environment variable)

Docker build:

```bash
docker build \
  --build-arg MC_VERSION=1.16.3 \
  --build-arg PAPER_BUILD=202 \
  -t images.lit.plus/papermc:1.16.3-92 \
  .
```

PaperMC is an optimized Minecraft server with plugin support (Bukkit, Spigot, Sponge, etc.).
This image provides a basic PaperMC server. All customizations are left to the user.
# Usage
It is assumed that the user has already acquired a working Docker installation. If that is not the case, go do that and come back here when you're done.
# Technical
This project *does **NOT** redistribute the Minecraft server files*. Instead, the (very small) script that is inside of
the image, `papermc.sh`, downloads these files from their official sources during installation.

**Note:** This is supposed to be either build locally and used only there or
be pushed to a private Docker registry. Uploading the binary image to a
public repository would be a copyright violation.

**PLEASE NOTE:** This is an unofficial project. I did not create PaperMC. [This is the official PaperMC website.](https://papermc.io/)
