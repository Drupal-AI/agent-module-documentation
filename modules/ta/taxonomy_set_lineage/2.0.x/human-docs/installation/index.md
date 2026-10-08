# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's taxonomy handling — there are no additional contributed module or PHP library
  dependencies.

This module is minimally maintained, so test it on a copy before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_set_lineage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_set_lineage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_set_lineage -y
```

After enabling, turn lineage on for the vocabularies you want and make sure your
taxonomy reference fields allow multiple values, so the added parent terms have
somewhere to go. See the [main guide](../index.md#how-to-use-it) for the full
walk-through, including how to backfill existing content with the **Update Taxonomy
Term Parents** bulk action.

## Verify it worked

On a vocabulary with lineage enabled, edit a piece of content, select a child term in
a multi-value taxonomy reference field, and save. Re-open it: the term's parent terms
should now also be present in the field.
