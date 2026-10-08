# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core's **Views** module (`views`), which is part of the standard install and
  enabled automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/glidejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/glidejs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en glidejs -y
```

## Verify it worked

Go to **Structure → Views**, edit any view, and open its **Format** setting. If
**Glide Carousel** appears as an available display format, the module is installed
correctly — select it and configure the carousel as described on the
[overview page](../index.md).
