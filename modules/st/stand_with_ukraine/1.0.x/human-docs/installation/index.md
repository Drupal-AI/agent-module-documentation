# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third-party Composer packages, PHP libraries, or contrib module
  dependencies. Core's Block system is all it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/stand_with_ukraine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stand_with_ukraine -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stand_with_ukraine -y
```

## Place the banner block

Enabling the module exposes the block but does not display it anywhere yet. Go to
**Structure → Block layout** (`/admin/structure/block`), click **Place block** on
the region you want, and choose the **Stand With Ukraine block**. Save the block —
the banner overlay appears immediately for anyone who can view content.

## Verify it worked

Visit any page where the block is placed (as an anonymous visitor if you like).
You should see the `#StandWithUkraine` overlay banner; clicking it takes you to
`https://war.ukraine.ua/`.
