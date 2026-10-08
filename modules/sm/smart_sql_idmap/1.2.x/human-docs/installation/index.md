# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. In practice you'll
usually also have `migrate_plus` and `migrate_tools` installed to define and run
migrations, but they aren't hard dependencies of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_sql_idmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/smart_sql_idmap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_sql_idmap -y
```

There's nothing to configure. To use it, set `idMap: { plugin: smart_sql }` in a
migration definition — see [How to use it](../index.md#how-to-use-it) on the
overview page.

> **Note:** the module includes an update hook that migrates any pre-existing
> `smart_sql` map data into the current table schema, so it's safe to update in
> place.
