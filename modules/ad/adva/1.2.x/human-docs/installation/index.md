# Installation

## Requirements

Advanced Access is built on Drupal core with no third-party libraries:

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- No other module dependencies for the base API, and no Composer/PHP library
  requirements.

The submodules add their own targets: **adva_na** applies to nodes and
**adva_media** applies to media (so it expects core Media).

## Install with Composer

From the project root:

```bash
composer require drupal/adva -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/adva -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base API:

```bash
drush en adva -y
```

The base module is an API — on its own it changes no access. You almost always want
one of the submodules too.

## Submodules — enable the entity types you want to control

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Advanced Access: Nodes** | `adva_na` | Applies adva to nodes using a *basic* consumer that bridges to core's node-grant system. Because core enforces node grants consistently on both direct access and listings, this path fails closed. |
| **Advanced Access: Media** | `adva_media` | Applies adva to media using an *overriding* consumer that takes over media access handling. |
| **Advanced Access: Example Provider** | `adva_example_provider` | A hidden reference Access Provider for developers to copy when writing their own. Not meant for production use. |

Enable, for example, node access control with:

```bash
drush en adva_na -y
```

Then continue to [Configuration](../configuration/index.md).
