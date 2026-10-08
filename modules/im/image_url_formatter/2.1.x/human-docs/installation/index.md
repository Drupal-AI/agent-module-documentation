# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Image** module (`image`), which is part of the standard Drupal install
  and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/image_url_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_url_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_url_formatter -y
```

There is no configuration step and no settings page. Once enabled, **Image URL
Formatter** (and **File URL Formatter** for file fields) appears as a display
format option on any image or file field — see the **How to use it** section on
the [overview page](../index.md).
