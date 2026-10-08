# Installation

## Requirements

- **Drupal 10.1+** (`core_version_requirement: ^10.1`).
- Core's **Block** module (`block`).
- The contrib **Menu Block** module (`menu_block`) — a hard dependency; the mega
  menu is built on top of it.
- **Sector distribution context.** This is a Sector add-on that extends the Sector
  Starter Kit and expects Sector's "Main menu block" and its menu block from the
  Sector distribution. It is really intended for Sector-based sites.

There are no third-party PHP or library requirements, and there are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_megamenu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Menu Block and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_megamenu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sector_megamenu -y
```

Enabling it will also enable Block and Menu Block if they are not already on.

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and click **Place
block**. You should see the **Mega Menu Root** and **Mega Menu Body** blocks
available to place. Placing and configuring them is covered in the
[main guide](../index.md).
