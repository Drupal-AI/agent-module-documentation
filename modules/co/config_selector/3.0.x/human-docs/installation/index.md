# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Nothing else — there are no module dependencies and no third‑party Composer or PHP libraries.

Note that the module is only *useful* to a module or install profile that ships competing
optional configuration; on its own it does nothing until a config entity opts into a feature.

## Install with Composer

From the project root:

```bash
composer require drupal/config_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/config_selector -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_selector -y
```

Any config entity that participates in a feature must list `config_selector` as a module
dependency (see [Configuration](../configuration/index.md)), so the module needs to be enabled
before — or in the same operation as — the modules that ship those variants.

There are no submodules.
