# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no dependencies beyond Drupal core, no third‑party libraries, and no special PHP
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/noreqnewpass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/noreqnewpass -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noreqnewpass -y
```

There are no submodules.

## After enabling

Enabling the module changes **nothing** by itself — its behavior is off until you tick the
setting. Head to [Configuration](../configuration/index.md) to turn off the password‑reset
flow, and to grant the permission that controls who may change it.
