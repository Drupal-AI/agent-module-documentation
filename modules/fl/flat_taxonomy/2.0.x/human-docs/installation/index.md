# Installation

## Requirements

Flat Taxonomy is very light. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module enabled — that's what the module hooks into. There are no
  other module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flat_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flat_taxonomy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flat_taxonomy -y
```

That's the whole setup. There are no submodules and no configuration form. To start
using it, edit any vocabulary and tick **Flat taxonomy** — see
[How to use it](../index.md#how-to-use-it) on the overview page.
