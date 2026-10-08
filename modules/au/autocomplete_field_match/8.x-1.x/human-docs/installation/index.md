# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules. Field is
  part of a standard install; enable Field UI if it is not already on. Drupal
  enables these as dependencies when you turn on the module.
- No third-party Composer or PHP library requirements.

> **Note:** the current release is an alpha (`8.x-1.0-alpha6`). Test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_field_match -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autocomplete_field_match -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_field_match -y
```

Once enabled, choose the field to match in a field's autocomplete widget
settings under **Manage form display**, as described on the [overview
page](../index.md). There is no separate site-wide configuration screen.
