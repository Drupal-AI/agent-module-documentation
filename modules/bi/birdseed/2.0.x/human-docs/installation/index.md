# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **BirdSeed account / API credentials** to connect the integration.

There are no additional module dependencies and no third-party Composer or PHP
library requirements listed.

> **Note:** This is a development release (`2.0.x-dev`). Test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/birdseed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/birdseed -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en birdseed -y
```

After enabling, continue to [Configuration](../configuration/index.md) to store your
BirdSeed credentials securely.
