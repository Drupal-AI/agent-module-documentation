# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies — it works against core's field rendering alone.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fences -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fences -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fences -y
```

That is all it takes — the **Fences** section now appears under each field on Manage
display for users who have the right permission (see
[Configuration](../configuration/index.md)).

## Submodule — Fences Presets (optional)

Fences ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Fences Presets** | `fences_presets` | Reusable named tag bundles (for example *Inline*, *Inline Label*, *None*) that you can apply to a field in one click, instead of setting each wrapper tag by hand. |

Enable it if you want the one‑click presets:

```bash
drush en fences_presets -y
```

It requires the base Fences module, which is already present once you have installed it
above.
