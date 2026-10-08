# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).

The base Modifiers module has **no dependencies** — it is a framework. To get
usable styling options you will typically also install companion modules:

- **[Modifiers Pack](https://www.drupal.org/project/modifiers_pack)** — a ready
  set of modifier plugins (colours, backgrounds, gradients, corners, shadow,
  parallax, and more).
- **[Look](https://www.drupal.org/project/look)** — manage collections of
  modifiers and apply them per page.

There are no third‑party Composer or PHP library requirements for the base
module.

## Install with Composer

From the project root:

```bash
composer require drupal/modifiers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/modifiers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modifiers -y
```

## Verify it worked

The base module provides the framework rather than a visible feature, so the best
confirmation is to add a source of modifier plugins. Install and enable
**Modifiers Pack**, attach a modifiers field to an entity/block/paragraph, and
confirm you can pick a modifier and see its styling applied on the rendered page.
See the [main guide](../index.md) for how the pieces fit together.
