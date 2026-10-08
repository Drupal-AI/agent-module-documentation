# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other module dependencies. To apply the schema change you will also want a
  way to run entity updates — see "How to use it" in the
  [overview](../index.md#how-to-use-it) (the `drush entity-updates` command,
  provided by the Devel Entity Updates module).

## Install with Composer

From the project root:

```bash
composer require drupal/field_add_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_add_index -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_add_index -y
```

## Verify it worked

Edit any supported field under **Manage fields** — you should now see an **Add
Index** option on the field's edit form. See the
[overview](../index.md#how-to-use-it) for the full flow, including applying the
schema change so the index is created.
