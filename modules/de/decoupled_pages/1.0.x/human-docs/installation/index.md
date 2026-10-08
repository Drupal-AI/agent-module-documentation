# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).

There are no module dependencies, no third‑party Composer packages, and no
front‑end library requirements — you supply your own SPA as an asset library.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_pages -y
```

## Submodules

Decoupled Pages ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Decoupled Pages Test** | `decoupled_pages_test` | A test helper used by the module's own test suite. You do not need to enable it for normal use. |

## Verify it worked

The quickest check uses the library the module ships for exactly this purpose.
Define a route in a small custom module with
`_decoupled_page_main: decoupled_pages/route_test`, rebuild the cache
(`drush cr`), enable your module, and visit the path you defined. Open your
browser's developer console — the test library prints a message confirming the
route worked. Once that succeeds, point `_decoupled_page_main` at your own SPA's
asset library. (See "How to use it" on the [overview page](../index.md).)
