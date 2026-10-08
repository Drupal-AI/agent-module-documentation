# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules and no third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/library_renderer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_renderer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_renderer -y
```

There are no submodules and no settings form to configure.

## Verify it worked

1. Confirm **Library renderer** is enabled on **Extend** (`/admin/modules`).
2. Add a `library_renderer` section to a library in a theme's `*.libraries.yml`
   (see the [main page](../index.md) for the syntax), and clear the cache.
3. Load a page that meets the condition you declared and one that doesn't — the
   library's assets should appear only on the matching page.

There is no configuration step beyond the YAML in your library definitions.
