# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Migrate** module (`migrate`) — Drupal enables it automatically as a
  dependency.
- **Drush 13** (`drush/drush: ^13`) — the whole feature is driven through Drush,
  so this is a hard requirement pulled in by Composer.

There are no other third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_boost -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (such as Drush) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_boost -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_boost -y
```

That is all the module needs to be present. It does nothing on its own until you
add the `hooks` / `modules` settings (see the [main page](../index.md)) and run a
migrate command — nothing changes for normal web traffic.

## Submodules

None — Migrate Booster ships as a single module.
