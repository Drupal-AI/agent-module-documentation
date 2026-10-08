# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contrib dependencies. It works with core's Node and Taxonomy modules — only
  **node** content types and **taxonomy term** vocabularies are supported.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/unique_entity_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/unique_entity_title -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unique_entity_title -y
```

Enabling the module does not change any behaviour on its own — no bundle enforces
unique titles until you switch it on for that content type or vocabulary. See
[Configuration](../configuration/index.md).

> **Upgrading from an older release?** Run `drush updatedb` after updating. The
> module's update hook migrates legacy per‑vocabulary settings into the new
> per‑vocabulary storage.

This module has no submodules.
