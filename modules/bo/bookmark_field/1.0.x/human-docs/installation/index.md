# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** (`field`) and **Block** (`block`) modules — both are enabled
  by default in a standard Drupal install, and Drupal enables them as
  dependencies if needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bookmark_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bookmark_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bookmark_field -y
```

There are no submodules. Once enabled, add the bookmark field to a content type
or place the bookmark block — see the [overview](../index.md#how-to-use-it).
