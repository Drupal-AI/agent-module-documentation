# Installation

## Requirements

Views Selective Filters needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of a standard Drupal install.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/views_selective_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_selective_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_selective_filters -y
```

That is all. There is no settings page and no permissions to grant — the module
simply adds a "(selective)" variant of each filterable field to the Views UI.

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Edit any view at **Structure → Views**, add a filter, and look for entries ending
in **"(selective)"** in the filter list. Their presence confirms the module is
active. See the [overview](../index.md#how-to-use-it) for how to place one.
