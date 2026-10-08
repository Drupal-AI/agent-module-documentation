# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** and **Filter** modules (both are standard on any site with
  content fields and text formats). They are the module's only dependencies.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/allowed_text_format_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allowed_text_format_field_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allowed_text_format_field_widget -y
```

This is a release candidate (1.1.0-rc1) — test it before production use. There is
no settings page; you choose the allowed formats in each text field widget's
settings on **Manage form display** — see [the overview](../index.md) for the
steps.
