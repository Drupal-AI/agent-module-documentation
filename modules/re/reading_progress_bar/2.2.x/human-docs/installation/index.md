# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (enabled by default) — the progress bar is delivered as
  a block. The bar's behavior uses core JavaScript (`core/drupal`, `core/once`),
  so there is no third-party library to install.

There are no additional Composer or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reading_progress_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reading_progress_bar -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reading_progress_bar -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**Reading Progress Bar block** is available to place. Add it to a region, save,
clear caches, then open a long page and scroll — the bar at the top should fill as
you go. See [Configuration](../configuration/index.md) for tuning its look and
behavior.
