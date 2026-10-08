# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- A **SmugMug developer application** — you register one to get the API key and
  secret you'll enter in configuration (see below).

There are no dependent modules and no third‑party PHP library requirements (the
module uses Guzzle, which ships with Drupal core).

## Install with Composer

From the project root:

```bash
composer require drupal/smugmug_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smugmug_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smugmug_api -y
```

## Next step

Register your application with SmugMug and enter the API key and secret — see
[Configuration](../configuration/index.md).
