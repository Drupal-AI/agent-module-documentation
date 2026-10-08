# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Auto Node Translate** (`drupal/auto_node_translate` `^3.0`) — the module this
  one extends. Composer installs it for you. Its translation‑provider configuration
  is what Auto Node Translate Bulk reuses, so you configure the provider there, not
  here.

> **Note:** this release is a release candidate (`2.0.0-rc4`), so test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ant_bulk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in `auto_node_translate ^3.0`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ant_bulk -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ant_bulk -y
```

Drupal enables Auto Node Translate at the same time. Make sure Auto Node Translate's
provider is configured, then see [Configuration](../configuration/index.md) for the
settings form and permissions.
