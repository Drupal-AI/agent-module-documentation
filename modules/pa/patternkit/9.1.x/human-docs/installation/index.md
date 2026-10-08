# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No required contrib module dependencies for the base module.
- A **pattern library** to load — a directory of Twig templates, each with a
  matching JSON Schema (Draft 4+) file. You can point Patternkit at your theme's
  existing templates, or use the bundled example library to start.

There are no third‑party PHP library requirements.

> **Heads up:** this project does not have official security‑advisory coverage,
> and it renders editor‑supplied field values — read the security note in the
> [overview](../index.md) and [Configuration](../configuration/index.md) before
> using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/patternkit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/patternkit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en patternkit -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Patternkit Example** | `patternkit_example` | A set of ready‑to‑use example patterns. Enable it to see Patternkit working out of the box before wiring up your own library. |
| **Patternkit Media Library** | `patternkit_media_library` | Integration with Drupal's Media Library for pattern fields that reference media. |
| **Patternkit Usage Tracking** | `patternkit_usage_tracking` | Tracks where patterns are used across the site. |

For example, to try the examples first:

```bash
drush en patternkit_example -y
```

## Verify it worked

Enable **Patternkit Example**, clear caches, then go to **Structure → Block
layout** (`/admin/structure/block`) or open Layout Builder — the example patterns
should appear as available blocks. Once you've confirmed that, continue to
[Configuration](../configuration/index.md) to register your own pattern library.
