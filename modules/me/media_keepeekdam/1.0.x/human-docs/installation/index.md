# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- These core modules, all enabled automatically as dependencies:
  **Media**, **Media Library**, **File**, **Image**, **Responsive Image**, and
  **Language**.
- A **Keepeek DAM account** and **API credentials** for it (needed to connect —
  see [Configuration](../configuration/index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_keepeekdam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_keepeekdam -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_keepeekdam -y
```

Drupal will pull in the required core modules (Media Library, Responsive Image,
Language, and so on) at the same time.

## Verify it worked

After enabling, continue to [Configuration](../configuration/index.md) to store
your Keepeek API credentials and connect the module. The integration only becomes
useful once those credentials are in place — until then, no Keepeek assets will
appear in the Media Library.
