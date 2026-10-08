# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`), part of a standard Drupal install and enabled
  automatically as a dependency — it's the text-format system this module plugs into.
- No third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_table_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/responsive_table_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_table_filter -y
```

Enabling the module makes the **Responsive Table filter** available on your text formats,
but it does nothing until you switch it on for a format. See
[How to use it](../index.md#how-to-use-it) on the main page for that step.
