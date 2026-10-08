# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Lock.

There are no third‑party Composer or PHP library requirements. (This version is a
release candidate, `2.0.0-rc2`.)

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_lock -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_lock -y
```

After enabling, head to **People → Permissions** to grant the lock‑management
permissions, then set locks on your sections — see
[Configuration](../configuration/index.md).

## Verify it worked

On a Layout Builder default layout, click **Configure section** on any section. You
should see the lock options (update, move, delete blocks; configure the section;
add a section before/after; move blocks in from other sections). If they appear,
the module is working.
