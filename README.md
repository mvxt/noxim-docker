# noxim-docker

[Noxim](https://github.com/davidepatti/noxim) is a Network-on-Chip (NoC) simulator created by the University of Catania (Italy). [Visit the page](https://github.com/davidepatti/noxim) for more details on that project. This repository houses the Dockerfile which builds the [Docker Container](https://hub.docker.com/r/mikeyvxt/noxim/).

# Download
The easiest way to get the Docker container is to clone it directly from DockerHub:
```bash
docker pull mikeyvxt/noxim
```

If for some reason that offends you, you can clone this repository and run `docker build .` locally.

# Usage
The container uses the `noxim` executable as an entrypoint script. You will need to map a volume with your config files and then specify the paths to the files as arguments to the container.

If, for example, I have my configuration in a folder `./config` from my current location:
```bash
docker run -v $(pwd)/config:/etc/noxim mikeyvxt/noxim -config /etc/noxim/default_config.yaml -power /etc/noxim/power.yaml
```

I'm currently dreaming up ways to make this a little less messy. Questions and contributions welcome.