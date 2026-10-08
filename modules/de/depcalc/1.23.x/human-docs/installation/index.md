# Installation

## Requirements

- **Drupal 9.4.15 or newer, 10, or 11** (`core_version_requirement: ^9.4.15 || ^10 || ^11`).
- **PHP 7.4.0 or newer** (`php: >=7.4.0`).

Depcalc has no contrib dependencies and no third‑party PHP libraries — it builds
only on Drupal core's entity and cache systems.

## Install with Composer

From the project root:

```bash
composer require drupal/depcalc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In many cases Depcalc arrives automatically as a
dependency of another module (for example a content‑staging tool), in which case
Composer has already pulled it in.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/depcalc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en depcalc -y
```

There is no configuration to do — Depcalc is an API used by other code. To
confirm it's working, the module registers the `cache_depcalc` database table and
the `depcalc:clear-cache` Drush command.

## Submodules — enable only what you need

Depcalc ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Depcalc UI** | `depcalc_ui` | A "Clear depcalc cache" button in the admin interface, for people who prefer clicking to running the Drush command. |

Enable it with:

```bash
drush en depcalc_ui -y
```

It requires the base Depcalc module, which is already present once you have
installed it above.
