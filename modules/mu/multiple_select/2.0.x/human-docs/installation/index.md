# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third-party Composer libraries.
- Optional: the **Field Group** module — if present, the master checkbox is moved
  inside a field-group container so it stays next to its field. Not required.

## Install with Composer

From the project root:

```bash
composer require drupal/multiple_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiple_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiple_select -y
```

## Grant the permission

The configuration page is gated by the **Access multiple select config page**
permission. Grant it to the roles that should manage the helper at **People →
Permissions** (`/admin/people/permissions`), then continue to
[Configuration](../configuration/index.md) to choose which fields get the Select-All
toggle. Nothing changes on any edit form until you configure at least one field.
