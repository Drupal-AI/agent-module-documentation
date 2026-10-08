# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/calculator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calculator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calculator -y
```

Core's Block module is enabled automatically as a dependency.

## Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** in your chosen region, and select the **Calculator** block. The
calculator appears wherever you place it.
