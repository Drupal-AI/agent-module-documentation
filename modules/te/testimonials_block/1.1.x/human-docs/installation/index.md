# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** (`block`) module, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and the module
provides no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/testimonials_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/testimonials_block`)
matches the module's machine name (`testimonials_block`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/testimonials_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en testimonials_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and place a new
block. The **Testimonials** block should appear in the list of available blocks.
Continue to [Configuration](../configuration/index.md) to add your testimonials
and set the display options.
