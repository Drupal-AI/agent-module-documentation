# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/notifybar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notifybar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notifybar -y
```

## Verify it worked

Go to **Structure → Block layout** and confirm a block named **Notifybar** is
available to place. Add it, set a message and colours (see
[Configuration](../configuration/index.md)), clear caches, and reload the site —
the notification bar should appear across the page.
