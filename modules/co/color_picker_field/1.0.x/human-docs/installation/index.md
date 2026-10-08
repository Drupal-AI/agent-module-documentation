# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core **Field** (`field`), which is part of a standard install.

There are no other module or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/color_picker_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/color_picker_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en color_picker_field -y
```

## Verify it worked

On a content type's **Manage fields** screen, start adding a field — the **Color
Picker** field type should appear in the list. See "How to use it" on the
[overview page](../index.md) for the rest of the setup.
