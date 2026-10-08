# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Filter** (`filter`) and **Path Alias** (`path_alias`) modules —
  both ship with core and are enabled automatically as dependencies.
- No third-party PHP or JavaScript libraries.

> **Heads-up:** this is an **alpha** release and is **not** covered by Drupal's
> security advisory policy. It rewrites stored content in bulk, so back up your
> database and test on a copy before running it against production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_links_bulk_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_links_bulk_processor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_links_bulk_processor -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Links Autosave** | `entity_links_autosave` | Runs the same link/markup processing as content is saved, so newly added legacy markup is cleaned up on the fly rather than only during one-time batch runs. Enable it if you want ongoing, real-time cleanup. |

Enable it only if you need the ongoing processing:

```bash
drush en entity_links_autosave -y
```

## Verify it worked

Log in as a user with the module's permissions. The bulk-processing tools should
be available in the admin UI. Before doing a real run, confirm you have a database
backup and, ideally, run against a copy of the site first.
