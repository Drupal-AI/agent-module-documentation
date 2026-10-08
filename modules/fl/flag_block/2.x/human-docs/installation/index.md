# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`).
- The **Flag** module (`flag`).

Both are enabled as dependencies. There are no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flag_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag module
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_block -y
```

This also enables the Block and Flag modules if they aren't already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. You should find the Flag Block available. Place it in a region, pick a
flag in its **Flag** setting, and save — the flag link should then appear in that
region on your site.
