# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** (`field`) and **System** (`system`) modules — both part of a
  standard Drupal install.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/set_field_defaults -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/set_field_defaults -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en set_field_defaults -y
```

You can also enable it from the **Extend** page (`/admin/modules`).

## Configure it

Once enabled, go to **Configuration → System → Field Default Values**
(`/admin/config/field-defaults`) to define the default values per field type. See
[Configuration](../configuration/index.md).
