# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — used to place the tag-cloud block.
- Core's **Taxonomy** module (`taxonomy`) — the source of terms for the cloud.

Both are core modules and are enabled automatically as dependencies. There are no
PHP library or extension requirements.

> **A note on versions.** This documentation covers the Drupal 8+ (`1.x`) line. The
> project's older `1.x` releases for Drupal 6/7 are a different story historically,
> but on modern Drupal you simply require the module with Composer as below.

## Install with Composer

From the project root:

```bash
composer require drupal/tagadelic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tagadelic -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tagadelic -y
```

## Verify it worked

After enabling, place the Tagadelic block via **Structure → Block layout**, or
create a View and choose the **Tagadelic List** style. With some taxonomy terms in
use, you should see a cloud in which more frequently used terms appear larger. See
the [main guide](../index.md) for the block, page, and Views options.
