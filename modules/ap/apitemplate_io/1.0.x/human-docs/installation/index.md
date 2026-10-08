# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **APITemplate.io account** and an **API key** — the module is a client for
  that external service, so you need a key to do anything useful.

There are no other module dependencies and no third-party PHP library
requirements; the module talks to the API over Drupal's built-in HTTP client.

## Install with Composer

From the project root:

```bash
composer require drupal/apitemplate_io -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apitemplate_io -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apitemplate_io -y
```

There are no submodules. After enabling, enter your API endpoint and key on the
settings form — see [Configuration](../configuration/index.md).
