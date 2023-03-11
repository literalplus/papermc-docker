# PaperMC Docker
This is a Linux Docker image for the PaperMC Minecraft server.

This fork is optimised for usage in Kubernetes. It requires the following
setup to be done by Kubernetes (perferably a stateful set):
 * A persistent volume mounted at /data/worlds/ (world data)
 * A persistent volume mounted at /data/papermc/ (server root directory)
 * server.properties (ConfigMap) needs to have:
   * `level-name=/data/worlds/this-last-part-is-arbitrary` (world storage location)
   * `enable-rcon=true` (so you can issue console commands)
   * `rcon.password=XXX` (must match the RCON_PW environment variable)

This fork ships with the [rcon-cli](https://github.com/itzg/rcon-cli)
binary (Apache License), which means you can just open a shell in the pod
and run `rcon-cli` for a Minecraft server console.

Docker build:

```bash
export MC_VERSION=1.19.3
export PAPER_BUILD=446
docker build \
  --build-arg MC_VERSION=${MC_VERSION} \
  --build-arg PAPER_BUILD=${PAPER_BUILD} \
  -t images.lit.plus/papermc:${MC_VERSION}-${PAPER_BUILD} \
  .
docker push images.lit.plus/papermc:${MC_VERSION}-${PAPER_BUILD}
```

PaperMC is an optimized Minecraft server with plugin support (Bukkit, Spigot, Sponge, etc.).
This image provides a basic PaperMC server. All customizations are left to the user.
# Usage
It is assumed that the user has already acquired a working Docker installation. If that is not the case, go do that and come back here when you're done.
# Technical
This project *does **NOT** redistribute the Minecraft server files*. Instead, the (very small) script that is inside of
the image, `papermc.sh`, downloads these files from their official sources during installation.

**Note:** This is supposed to be either build locally and used only there or
be pushed to a private Docker registry. Specifically, it is important that
the image automatically indicates agreement with the Minecraft EULA via
the eula.txt. Hence, the Docker build must only be run if you actually
agree to the terms of the Minecraft EULA.

**PLEASE NOTE:** This is an unofficial project. I did not create PaperMC. [This is the official PaperMC website.](https://papermc.io/)
