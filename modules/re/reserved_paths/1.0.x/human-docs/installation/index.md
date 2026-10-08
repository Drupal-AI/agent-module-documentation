# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. It integrates with **Pathauto** if you have it installed, but Pathauto
is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/reserved_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reserved_paths -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reserved_paths -y
```

## Verify it worked

Go to **Configuration → Reserved Paths** (`/admin/config/reserved-paths`). You
should see a textarea for your reserved paths. Add one, save, then try to give a
piece of content that alias — Drupal should reject it. See
[Configuration](../configuration/index.md) for how to build the list.
