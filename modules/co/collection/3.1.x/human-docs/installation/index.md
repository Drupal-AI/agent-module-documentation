# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- These modules, which Composer/Drupal pull in as dependencies:
  - **Dynamic Entity Reference** (`dynamic_entity_reference`)
  - **Inline Entity Form** (`inline_entity_form`)
  - **Key value field** (`key_value_field`)
  - core **Path** (`path`)
- Optionally, **Paragraphs** (for the Collection Listing submodule) and
  **Pathauto** (for the Collection Pathauto submodule).

## Install with Composer

From the project root:

```bash
composer require drupal/collection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including the required contrib modules, as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/collection -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en collection -y
```

This also enables the required dependencies if they are not already on.

## Optional submodules

Collection bundles two optional submodules:

- **Collection Listing** (experimental) — lets you build listings of a
  collection's items for placement on another entity, via **Paragraphs**. Enable
  Paragraphs first, then the submodule.
- **Collection Pathauto** — when **Pathauto** is present, prepends a collection's
  URL alias to the aliases of the content it contains.

Enable whichever you need with `drush en <submodule> -y`.

## Verify it worked

Go to **Structure** and look for **Collection types**, and **Content** for the
collections listing. If both appear, the module is installed. Continue to
[Configuration](../configuration/index.md) to create your first collection type.
