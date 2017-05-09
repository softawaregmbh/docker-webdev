<h1 align="center">softaware/webdev - Examples</h1>

The following examples show sample cases how the containers can be used in real projects. Our goal is to simplify the usage as much as possible thus providing a *consistent workflow across multiple projects*.

All of the following examples are intended to be added to a project in the *root-folder*. Now a *reproducable node-environment* can be started with:
```
.\docker-devenv.ps1   <return>
```

## Simple *([code](./01%20simple))*
The container is started with a traditional `docker container run` command using `it` for interactive and `--rm` to immediately remove the container usage.
`-v ${pwd}:/usr/src/app` maps the current directory into the container.

The Powershell-Script acts as a shortcut for starting the container.

| + | - |
| :---: | :---: |
| easy to understand | not customizable |
| | container has generated name (see [Advanced](#advanced)) |


## Advanced *([code](./02%20advanced))*
In this example the `run`-Command is identical to the Simple example. The only *difference* is the *container naming*.
The startscript looks for a projectname defined in a `package.json` or uses the foldername otherwise.
Additionally the container is suffixed with `webdev` to provide easier recognition by name for [`docker attach`](https://docs.docker.com/engine/reference/commandline/container_attach/).

The idea behind this script is to allow multiple projects' containers to be started in parallel and give them meaningful names.
You can either start your container with `--name`, but then you cannot start multiple containers, or not provide a name at all, but lose meaningful names.
This approach handles both cases.

| + | - |
| :---: | :---: |
| run multiple containers | not customizable |
| and [`attach`]((https://docs.docker.com/engine/reference/commandline/container_attach/)) to them | |

## Custom *([code](./01%20custom))*
This approach extends the Advanced example with a *custom container*.
The Dockerfile derives from `softaware/webdev:node-6.10.3`.
At the end the Angular CLI Port is exposed to enable the live-server.
Now you can customize your image whatever you like, e.g. `RUN npm install -g npm-check` installs a npm package "globally", which means in the *container only* in this case.

The `docker-devenv.ps1`-Script sets the whole thing up.
It does the naming as Advanced and further tries to build the container everytime.
This is no problem, because Docker does not rebuild a Layer if it is not a new one.

| + | - |
| :---: | :---: |
| customizable | [`build`](https://docs.docker.com/engine/reference/commandline/image_build/) necessary |
| multiple named containers | |
| start-script handles building | |