# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) and **Taxonomy** (`taxonomy`) modules. Drupal
  enables them automatically as dependencies (Views is on by default in a
  standard install).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_term_hierarchy_weight_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_term_hierarchy_weight_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_term_hierarchy_weight_field -y
```

When it's enabled the module immediately creates the two hierarchy fields
(**Hierarchical Weight** and **Hierarchical Depth**) on every existing
vocabulary, and it will add them to any new vocabulary you create later. There is
no configuration step — head straight to a taxonomy‑term View to sort by them
(see [How to use it](../index.md#how-to-use-it)).

## Submodules

Views Term Hierarchy Weight Field ships no submodules.
