# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third-party libraries and no other contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/typed_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/typed_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en typed_entity -y
```

The base module provides the framework only — it does nothing visible until you
write repositories and wrapped-entity classes in your own module.

## Submodules — optional helpers

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Typed Entity Example** | `typed_entity_example` | A working demonstration with Article and User repositories. Enable it to study the pattern; you'd typically remove it once you're comfortable. |
| **Typed Entity UI** | `typed_entity_ui` | An admin explorer at **Configuration → Development → Typed Entity** (`/admin/config/development/typed-entity`) that lists which wrapper/renderer classes apply to each entity-type/bundle. Adds the **Explore typed entity classes** permission. |

Enable either as needed:

```bash
drush en typed_entity_example typed_entity_ui -y
```

## Next step

See the module [overview](../index.md#how-to-use-it) for the coding pattern, and
the [`agent/`](../agent/start.md) docs for the full API.
