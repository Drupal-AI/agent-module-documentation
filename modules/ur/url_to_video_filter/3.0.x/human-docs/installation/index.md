# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ~11`).
- No other modules and no third‑party Composer or PHP libraries are required — the
  module is a single text filter.

## Install with Composer

From the project root:

```bash
composer require drupal/url_to_video_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/url_to_video_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_to_video_filter -y
```

The module ships no submodules. Enabling it does nothing until you turn the filter
on for a text format — see the [main guide](../index.md#how-to-use-it).
