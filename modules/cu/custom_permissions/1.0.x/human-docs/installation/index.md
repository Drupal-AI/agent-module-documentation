# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules, and no third‑party Composer or PHP library
  requirements — it depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_permissions -y
```

## Verify it worked

Log in as an administrator and go to **People → Custom Permissions**
(`/admin/people/custom-permissions`). You should see the interface for defining
custom permissions. See [Configuration](../configuration/index.md) for how to add
one and assign it to a role.
