# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — the only dependency. Views is on by
  default in the standard profile; if it is off, Drupal enables it as a dependency.

There are no third‑party Composer or PHP library requirements, and the module adds
no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/views_jump_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_jump_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_jump_menu -y
```

Once enabled, the **Jump Menu** format is available when you edit any view's
**Format**. See the module overview for how to set it up on a view. This module has
no submodules and no settings page.

> **Upgrading from an older release?** Run `drush updatedb` after updating so the
> module's update hook can backfill the "open in new window" option on any existing
> jump‑menu displays.
