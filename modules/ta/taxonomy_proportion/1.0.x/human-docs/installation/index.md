# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's taxonomy handling — there are no additional contributed module or PHP
  library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_proportion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_proportion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_proportion -y
```

## Verify it worked

Enabling the module makes a new **Taxonomy proportion** field type available. To
check, go to a content type's **Manage fields** page
(`/admin/structure/types/manage/{bundle}/fields`), click **Add field**, and confirm
that *Taxonomy proportion* appears in the field-type list. See the
[main guide](../index.md#how-to-use-it) for how to add and configure the field.
