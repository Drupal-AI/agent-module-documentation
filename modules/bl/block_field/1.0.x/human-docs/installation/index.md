# Installation

## Requirements

Block Field depends only on Drupal core:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's Field and Block systems, which are part of a standard install.

There are no contrib dependencies and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_field -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_field -y
```

Enabling the module makes the new **Block field** field type available. Nothing
changes on your content types until you add such a field — head to
[Configuration](../configuration/index.md) to add your first one.
