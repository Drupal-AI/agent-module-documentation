# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Note this
  release does not declare Drupal 11 support.
- Core's **Block** (`block`) module — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements; the calculator's
JavaScript and CSS ship with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/history_memory_calculator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/history_memory_calculator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en history_memory_calculator -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block** in any region — **History Memory Calculator Block** should appear in the
list. Place it, save, then visit a page in that region: the calculator should be
usable, with working memory, history, and pagination. See "How to use it" in the
[overview](../index.md) for placement details.
