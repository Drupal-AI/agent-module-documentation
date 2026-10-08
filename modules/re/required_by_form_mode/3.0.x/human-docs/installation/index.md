# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. It works well alongside the **Form Mode Manager** module if you use
custom form modes.

## Install with Composer

From the project root:

```bash
composer require drupal/required_by_form_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_by_form_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_by_form_mode -y
```

## Verify it worked

Pick a field, uncheck its base **Required field** setting, then open **Manage form
display** for one of the bundle's form modes. You should be able to mark that field
as required for just that form mode. See the "How to use it" section of the
[overview](../index.md) for the full walkthrough.
