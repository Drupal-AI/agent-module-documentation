# Installation

## Requirements

Block Group is core-only:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Block** module — Block Group extends the standard Block layout system.
- No contrib dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/blockgroup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/blockgroup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blockgroup -y
```

Once enabled, head to **Structure → Block layout → Block groups**
(`/admin/structure/block_group_content`) to create your first group — see
[Configuration](../configuration/index.md).

## Submodules

Block Group ships no submodules — the base module is everything you need.
