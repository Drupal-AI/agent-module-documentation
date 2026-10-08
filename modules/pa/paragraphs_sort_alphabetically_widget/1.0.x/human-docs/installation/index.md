# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements. The Paragraphs widget variants are only useful if you also run the
Paragraphs module, but Paragraphs is not required to install this module.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_sort_alphabetically_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_sort_alphabetically_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_sort_alphabetically_widget -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then open a
content type's **Manage form display** and check that the new alphabetical‑sort
widget appears in the widget list for eligible multi‑value fields.
