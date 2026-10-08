# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** and **Taxonomy** modules — enabled automatically as dependencies
  (they provide the title and term‑name uniqueness).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/unique_content_field_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unique_content_field_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unique_content_field_validation -y
```

## Submodules

The module ships no submodules.

## Next steps

Enabling the module adds "Unique" options to your field, content‑type, and
vocabulary forms, but turns nothing on by itself. See
[Configuration](../configuration/index.md) to enable uniqueness where you need it.
