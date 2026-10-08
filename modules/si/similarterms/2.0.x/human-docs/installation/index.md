# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Taxonomy** module (`taxonomy`) and **Views** module (`views`) enabled —
  Drupal enables both automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

### Optional companion: Taxonomy Entity Index

Similar By Terms works with nodes out of the box using core's `taxonomy_index`
table. If you want similarity to work for **other entity types** (media, users,
custom entities) or to cover unpublished content, install the suggested
[Taxonomy Entity Index](https://www.drupal.org/project/taxonomy_entity_index)
module:

```bash
composer require drupal/taxonomy_entity_index -W
drush en taxonomy_entity_index -y
```

Then configure which entity types it should index and run a rebuild (see that
module's own guide). Once it's enabled and populated, Similar By Terms exposes its
handlers on every indexed entity type.

## Install with Composer

From the project root:

```bash
composer require drupal/similarterms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/similarterms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en similarterms -y
```

There's no configuration form and no permissions to grant — once enabled, build a
view as described in the [main guide](../index.md#how-to-use-it).

This module ships no submodules.
