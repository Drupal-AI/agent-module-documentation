# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables by default — it is the
  only dependency.

There are no third‑party Composer or PHP library requirements. Note that this
project is **not covered by Drupal's security advisory policy**, so review it
yourself before using it on a production site.

At runtime the block loads Facebook's third‑party social‑plugin script, so plan
for the privacy/consent implications described in the [overview](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/facebook_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facebook_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facebook_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**Facebook Block** appears in the "Place block" list. Place it in a region, point
it at your Facebook page, and load a front‑end page where the block is visible to
confirm the Facebook content renders.
