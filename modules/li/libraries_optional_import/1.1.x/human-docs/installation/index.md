# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules and no third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/libraries_optional_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/libraries_optional_import -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en libraries_optional_import -y
```

There are no submodules and no configuration to set up.

## Verify it worked

1. Confirm **Libraries optional import** is enabled on **Extend**
   (`/admin/modules`).
2. In a theme, declare a library with an `optional: true` asset pointing at a file
   that does **not** exist, and attach that library to a page.
3. Load the page and check the source (or the aggregation report): the missing
   optional file should simply be absent, with no error — whereas without this
   module the same declaration would produce a "missing library file" warning.
   Clear the cache after editing `*.libraries.yml` so Drupal re‑reads the
   definition.

There is no configuration step — see the module's [main page](../index.md) for the
`optional: true` syntax.
