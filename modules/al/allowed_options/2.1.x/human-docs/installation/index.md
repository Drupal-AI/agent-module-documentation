# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A list/options field to apply it to (`list_string`, `list_integer`,
  `list_float`, or a boolean-style options field). These come from Drupal core.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/allowed_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allowed_options -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allowed_options -y
```

There is no settings page. Once enabled, the **Allowed options** control appears
in supported field widget settings on **Manage form display** — see
[the overview](../index.md) for how to use it.
