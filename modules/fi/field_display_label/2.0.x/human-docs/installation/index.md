# Installation

## Requirements

Field Display Label is lightweight. It needs:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it
  is on by default on any standard Drupal site.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_display_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_display_label -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_display_label -y
```

That's all it takes. There is no configuration screen and nothing to switch on —
the extra **Display label** field appears on every field's settings form
immediately. See the [How to use it](../index.md#how-to-use-it) section for setting
a display label on a field.
