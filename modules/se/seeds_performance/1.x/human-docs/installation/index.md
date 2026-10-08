# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Contrib modules** it depends on and enables: WebP (`webp`) and Ultimate Cron
  (`ultimate_cron`). Composer installs these for you.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_performance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in WebP and Ultimate
Cron and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_performance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_performance -y
```

Enabling Seeds Performance also enables WebP and Ultimate Cron.

## Verify it worked

Check **Extend** (`/admin/modules`) to confirm Seeds Performance, WebP, and
Ultimate Cron are all enabled. Then review each bundled module's own settings —
Seeds Performance has no settings page of its own — and test the site's behaviour
before deploying to production.
