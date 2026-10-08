# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a dependency,
  since the feature is delivered as a block.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/back_to_top_with_pi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/back_to_top_with_pi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en back_to_top_with_pi -y
```

Nothing appears until you place the block. Go to **Structure → Block layout** and add
the module's back‑to‑top block to a region — see the *How to use it* section on the
[overview page](../index.md).
