# Installation

## Requirements

Views Infinite Scroll is deliberately lightweight. It needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  Views is part of Drupal core.

There are no third‑party Composer packages or PHP library requirements. One thing
to remember is not a dependency but a setting: each View you use it on must have
**AJAX enabled** (see [How to use it](../index.md#how-to-use-it)).

## Install with Composer

From the project root:

```bash
composer require drupal/views_infinite_scroll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_infinite_scroll -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_infinite_scroll -y
```

Enabling the module does not change anything on its own — it simply makes the
**Infinite Scroll** pager available in the Views UI. See
[How to use it](../index.md#how-to-use-it) for switching a View's pager over to
it.
