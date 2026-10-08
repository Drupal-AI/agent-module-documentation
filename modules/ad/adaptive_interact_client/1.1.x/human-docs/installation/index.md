# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10||^11||^12`).
- An **Adaptive Interact** account, so you have the connection details /
  credentials for the platform.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adaptive_interact_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/adaptive_interact_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adaptive_interact_client -y
```

After enabling, continue to [Configuration](../configuration/index.md) to connect
the module to your Adaptive Interact account.
