# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Media** and **Media Library** modules enabled — Media Library Edit
  attaches to the core `media_library_widget`, so you need a working media library
  with at least one media-reference field.

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_edit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_edit -y
```

Enabling the module does not change any form by itself — you switch the edit button
on per widget under **Manage form display**. See
[How to use it](../index.md#how-to-use-it) on the overview page for the two settings
and where to find them.
