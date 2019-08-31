![Magento 2](https://cdn.rawgit.com/deepakworldphp86/magento2-snippets-visualstudio/master/images/icon.png)

#  Magento 2 Docker to Development

### Apache 2.4 + PHP 7.1 + OPCache + MariaDB + N98 Magerun 2 + XDebug + Redis

[![Build Status](https://travis-ci.org/deepakworldphp86/docker-magento2.svg?branch=master)](https://travis-ci.org/deepakworldphp86/docker-magento2)
[![Docker Build](https://img.shields.io/docker/build/deepakworldphp86/magento2.svg)](https://hub.docker.com/r/deepakworldphp86/magento2/)
[![Docker Pulls](https://img.shields.io/docker/pulls/deepakworldphp86/magento2.svg)](https://hub.docker.com/r/deepakworldphp86/magento2/)
[![Docker Starts](https://img.shields.io/docker/stars/deepakworldphp86/magento2.svg)](https://hub.docker.com/r/deepakworldphp86/magento2/)
[![Build Status](https://images.microbadger.com/badges/image/deepakworldphp86/magento2.svg)](https://microbadger.com/images/deepakworldphp86/magento2)
[![Releases](https://img.shields.io/github/release/cdeepakworldphp86/docker-magento2.svg)](https://github.com/deepakworldphp86/docker-magento2/releases)

### Requirements

**MacOS:**

Install [Docker](https://docs.docker.com/docker-for-mac/install/), [Docker-compose](https://docs.docker.com/compose/install/#install-compose) and [Docker-sync](https://github.com/EugenMayer/docker-sync/wiki/docker-sync-on-OSX).

**Windows:**

Install [Docker](https://docs.docker.com/docker-for-windows/install/), [Docker-compose](https://docs.docker.com/compose/install/#install-compose) and [Docker-sync](https://github.com/EugenMayer/docker-sync/wiki/docker-sync-on-Windows).

**Linux:**

Install [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).

### How to use

Execute in your terminal, change the *MYMAGENTO2* to use the name of your project:

```
curl -s https://raw.githubusercontent.com/deepakworldphp86/docker-magento2/master/init | bash -s MYMAGENTO2 clone
```

If you want to install the Magento 2, use like that:

```
cd MYMAGENTO2
./shell
rm index.php
install-magento2
```

You can specify the version that want install (e.g. `install-magento2 2.2`).

### Panels

Enjoy your new panels!

**Web server:** http://localhost/

**PHPMyAdmin:** http://localhost:8080

**Local emails:** http://localhost:8025

### Features commands

| Commands  | Description  | Options & Examples |
|---|---|---|
| `./init`  | If you didn't use the CURL setup command above, please use this command changing the name of the project.  | `./init MYMAGENTO2` |
| `./start`  | If you continuing not using the CURL you can start your container manually  | |
| `./stop`  | Stop your project containers  | |
| `./kill`  | Stops containers and removes containers, networks, volumes, and images created to the specific project  | |
| `./shell`  | Access your container  | `./shell root` | |
| `./magento`  | Use the power of the Magento CLI  | |
| `./n98`  | Use the Magerun commands as you want | |
| `./grunt-init`  | Prepare to use Grunt  | |
| `./grunt`  | Use Grunt specifically in your theme or completely, it'll do the deploy and the watcher.  | `./grunt luma` |
| `./xdebug`  |  Enable / Disable the XDebug | |
| `./composer`  |  Use Composer commands | `./composer update` |

### Elasticsearch 

To use elastic search you can use this command below:

`$ docker-compose -f docker-compose.yml -f docker-compose.elasticsearch.yml up`

or to run in the background using detached mode

`$ docker-compose -f docker-compose.yml -f docker-compose.elasticsearch.yml up -d`

**Elasticsearch:** http://localhost:9200

### License

MIT © 2019 [Deepak Kumar ](https://github.com/deepakworldphp86/) and [contributors](https://github.com/deepakworldphp86/docker-magento2/graphs/contributors).
