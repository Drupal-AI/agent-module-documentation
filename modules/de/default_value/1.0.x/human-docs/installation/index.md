# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies, and no PHP library or third‑party Composer
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/default_value -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_value -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Default Value
Settings**. If the settings form loads, the module is active and you can begin
choosing which fields should receive a load‑time default — see
[Configuration](../configuration/index.md).
