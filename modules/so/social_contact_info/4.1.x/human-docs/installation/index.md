# Installation

## Requirements

Social Contact Block is self-contained and lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Nothing else — there are no dependent modules, no PHP version constraint beyond
  what your Drupal core requires, and no third-party Composer or library
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/social_contact_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_contact_info -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_contact_info -y
```

## Verify it worked

The module adds no visible change on its own — it provides a block you place.
Go to **Structure → Block layout** (`/admin/structure/block`) and click
**Place block** in any region; you should find **Social Contact Block** in the
list. Place it and continue to [Configuration](../configuration/index.md) to fill
in your details.
