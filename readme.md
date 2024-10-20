# jupyter-clone
Spawn jupyterlab instances in docker container as you like in secure environment! Customize the requirements as needed at build time, and update requirements via rebuild (remove and build) with storage preservation in host filesystem. All instances are connected via bridge network.

## build
```bash
bash build.sh PROJECT_NAME
```

## stop
```bash
bash stop.sh PROJECT_NAME
```

## start
```bash
bash start.sh PROJECT_NAME
```

## remove
```bash
bash remove.sh PROJECT_NAME
```

## check instances connected to network
``` bash
docker network inspect jupyter-clone -f "{{json .Containers }}"
```