{
  config,
  pkgs,
  myvars,
  ...
}: {
  services.gitea-actions-runner.instances.nix = {
    enable = true;
    url = "https://zhixinghejia.synology.me:25001/";
    name = "work-305";
    tokenFile = config.age.secrets."gitea/runner-305.env".path;
    labels = [
      "ubuntu-latest:docker://node:16-bullseye"
      "ubuntu-22.04:docker://node:16-bullseye"
      "ubuntu-20.04:docker://node:16-bullseye"
      "ubuntu-18.04:docker://node:16-buster"
    ];
    settings = {
      log = {
        # The level of logging, can be trace, debug, info, warn, error, fatal
        level = "info";
      };
      runner = {
        # Where to store the registration result.
        file = ".runner";
        # Execute how many tasks concurrently at the same time.
        capacity = 5;
        # Extra environment variables to run jobs.
        envs = [];
        # Extra environment variables to run jobs from a file.
        # It will be ignored if it's empty or the file doesn't exist.
        env_file = ".env";
        # The timeout for a job to be finished.
        # Please note that the Gitea instance also has a timeout (3h by default) for the job.
        # So the job could be stopped by the Gitea instance if it's timeout is shorter than this.
        timeout = "3h";
        # Whether skip verifying the TLS certificate of the Gitea instance.
        insecure = false;
        # The timeout for fetching the job from the Gitea instance.
        fetch_timeout = "5s";
        # The interval for fetching the job from the Gitea instance.
        fetch_interval = "2s";
        # The labels of a runner are used to determine which jobs the runner can run, and how to run them.
        # Like: ["macos-arm64:host", "ubuntu-latest:docker://node:16-bullseye", "ubuntu-22.04:docker://node:16-bullseye"]
        # If it's empty when registering, it will ask for inputting labels.
        # If it's empty when execute `deamon`, will use labels in `.runner` file.
        labels = [];
      };
      cache = {
        # Enable cache server to use actions/cache.
        enabled = true;
        # The directory to store the cache data.
        # If it's empty, the cache data will be stored in $HOME/.cache/actcache.
        dir = "";
        # The host of the cache server.
        # It's not for the address to listen, but the address to connect from job containers.
        # So 0.0.0.0 is a bad choice, leave it empty to detect automatically.
        host = "";
        # The port of the cache server.
        # 0 means to use a random available port.
        port = 0;
        # The external cache server URL. Valid only when enable is true.
        # If it's specified, act_runner will use this URL as the ACTIONS_CACHE_URL rather than start a server by itself.
        # The URL should generally end with "/".
        external_server = "";
      };
      container = {
        # Specifies the network to which the container will connect.
        # Could be host, bridge or the name of a custom network.
        # If it's empty, act_runner will create a network automatically.
        network = "";
        # Whether to use privileged mode or not when launching task containers (privileged mode is required for Docker-in-Docker).
        privileged = false;
        # And other options to be used when the container is started (eg, --add-host=my.gitea.url:host-gateway).
        options = null;
        # The parent directory of a job's working directory.
        # If it's empty, /workspace will be used.
        workdir_parent = null;
        # Volumes (including bind mounts) can be mounted to containers. Glob syntax is supported, see https://github.com/gobwas/glob
        # You can specify multiple volumes. If the sequence is empty, no volumes can be mounted.
        # For example, if you only allow containers to mount the `data` volume and all the json files in `/src`, you should change the config to:
        # valid_volumes:
        #   - data
        #   - /src/*.json
        # If you want to allow any volume, please use the following configuration:
        # valid_volumes:
        #   - '**'
        valid_volumes = [];
        # overrides the docker client host with the specified one.
        # If it's empty, act_runner will find an available docker host automatically.
        # If it's "-", act_runner will find an available docker host automatically, but the docker host won't be mounted to the job containers and service containers.
        # If it's not empty or "-", the specified docker host will be used. An error will be returned if it doesn't work.
        docker_host = "";
        # Pull docker image(s) even if already present
        force_pull = false;
        # Rebuild docker image(s) even if already present
        force_rebuild = false;
      };

      host = {
        # The parent directory of a job's working directory.
        # If it's empty, $HOME/.cache/act/ will be used.
        workdir_parent = null;
      };
    };
  };
}
