# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements — the module ships
its own jQuery‑based JavaScript and CSS and relies on the jQuery that comes with
Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_countdown_timer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_countdown_timer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_countdown_timer -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** in any region, and confirm that **Countdown Timer** appears in the list.
See the [overview page](../index.md#how-to-use-it) for placing and configuring it.
