# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/config_perms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_perms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_perms -y
```

On enable, the module seeds four example custom permissions (Administer account
settings, Administer date time, Administer error logs, Administer file system) so
you can see how they work. Manage them, and create your own, on the **Custom
permissions** form — see [Configuration](../configuration/index.md).

There are no submodules.
