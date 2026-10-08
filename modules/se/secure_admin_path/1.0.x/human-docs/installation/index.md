# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other modules, PHP libraries, or third-party services are required.

The module provides its own permission for administering the path settings.

## Install with Composer

From the project root:

```bash
composer require drupal/secure_admin_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/secure_admin_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secure_admin_path -y
```

You can also enable it from **Extend** (`/admin/modules`). Enabling the module alone
does not change any paths yet — you must set the replacement terms on the settings
form first. See [Configuration](../configuration/index.md).

## A note on other modules

The module's own documentation warns that if another module stops working after the
paths are renamed, it is because that module hard-codes `/admin` or `/user` paths
instead of building them from route names. That is a limitation in the other module
and is not something Secure Admin Path can or should fix. Test your site after
changing the prefixes.

This project is **not covered by Drupal's security advisory policy** — and remember it
is an obscurity layer, not real access control (see the main guide).
