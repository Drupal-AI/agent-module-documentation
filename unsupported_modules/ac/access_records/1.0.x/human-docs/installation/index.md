# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** and **Options** modules (enabled by default).
- The **[Entity API](https://www.drupal.org/project/entity)** contrib module
  (`drupal/entity`) — **required**: it provides the query-access layer that
  enforces access on target entities at the database level. Without it, the
  database-level enforcement does not work.
- Core's **Field UI** enabled, so you can add matching fields to record types.

## Install with Composer

From the project root:

```bash
composer require drupal/access_records -W
```

Because Entity API is a dependency, `-W` (`--with-all-dependencies`) will pull it
in for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_records -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_records -y
```

(Ensure **Field UI** is also enabled so you can manage record fields.)

Once enabled, create a record type and its matching fields — see
[Configuration](../configuration/index.md).
