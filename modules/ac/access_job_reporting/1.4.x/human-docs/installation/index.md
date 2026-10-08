# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), enabled by default.
- **TAPIS Job** (`tapis_job`) and **TAPIS System** (`tapis_system`) — these
  provide the job and system entities the reporter reads. This module only makes
  sense on a gateway that already runs jobs through them.
- Optionally, the **[Key](https://www.drupal.org/project/key)** module, if you
  want to store the ACCESS API key as a Key entity rather than in plain
  configuration (recommended).

## Install with Composer

From the project root:

```bash
composer require drupal/access_job_reporting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_job_reporting -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_job_reporting -y
```

Once enabled, configure the endpoint, key and agent name at
[Configuration](../configuration/index.md) before job reports will be sent.
