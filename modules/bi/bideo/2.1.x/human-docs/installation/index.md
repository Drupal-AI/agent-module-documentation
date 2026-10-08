# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's Batch API (part of Drupal) — no separate module to enable.

There are no third-party Composer or PHP library requirements, and no external
services are involved.

## Install with Composer

From the project root:

```bash
composer require drupal/bideo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bideo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bideo -y
```

Then visit **Configuration → Batch Video** (`/admin/config/bideo/settings`) to pick
the video to display during batch operations.
