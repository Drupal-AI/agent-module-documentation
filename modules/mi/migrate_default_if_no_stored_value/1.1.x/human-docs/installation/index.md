# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency; Drupal enables it
  automatically.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_default_if_no_stored_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_default_if_no_stored_value -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_default_if_no_stored_value -y
```

## Verify it worked

There is no admin page. Add a `default_if_no_stored_value` process step to a
node migration (see [the module overview](../index.md#how-to-use-it)), run the
migration once to seed the default, then run it again with `--update` and confirm
existing values are left untouched.
