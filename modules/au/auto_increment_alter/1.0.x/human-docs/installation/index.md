# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **MySQL** database driver module (`mysql`) — the module works with MySQL
  and depends on it. It is not for PostgreSQL or SQLite sites.

There are no third-party Composer library requirements. Note the packaged release
is `1.0.0-alpha5`, an **alpha** — test it carefully before using it on important
data.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_increment_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_increment_alter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_increment_alter -y
```

After enabling, grant the module's permission only to trusted administrators, and
**back up your database** before altering any table's `AUTO_INCREMENT` value —
this runs a direct `ALTER TABLE` operation. See the [overview](../index.md) for
the cautions.
