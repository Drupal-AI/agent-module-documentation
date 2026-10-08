# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — this is a declared dependency and is part of
  standard Drupal.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/template_suggester -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/template_suggester -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en template_suggester -y
```

Enabling the module makes the **Template Suggester** field type available. It does
not do anything on its own until you declare suggestions, add the field, and create
the matching templates — see [Configuration](../configuration/index.md).

## Verify it worked

Go to a content type's **Manage fields** screen and add a field. The **Template
Suggester** field type should appear in the list of available field types.
