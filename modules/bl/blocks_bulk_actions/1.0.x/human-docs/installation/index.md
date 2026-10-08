# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's Block system, which is part of every standard Drupal install.

There are no third‑party Composer or PHP library requirements.

> **Note:** This release is an early (alpha) version, so test it on a
> non‑production copy of your site before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/blocks_bulk_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/blocks_bulk_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blocks_bulk_actions -y
```

Once enabled, the bulk‑action controls appear on **Structure → Block layout** —
see [How to use it](../index.md#how-to-use-it).
