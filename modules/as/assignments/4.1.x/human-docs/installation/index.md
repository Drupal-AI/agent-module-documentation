# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/assignments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/assignments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en assignments -y
```

Enabling it registers the Assignment content entity. From there, set up your
assignment types, add fields, and grant the entity permissions to the right roles
— see [How to use it](../index.md#how-to-use-it).

## Extensions

This module has no submodules, but it is the base other modules extend. If you
want to post assignment activity to social accounts, add
**Assignments Hootsuite** (`assignments_hootsuite`), which builds on this module
via OAuth2 — see its own guide
[here](../../assignments_hootsuite/4.3.x/human-docs/index.md).
