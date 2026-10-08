# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The **Facets Pretty Paths** module (`facets_pretty_paths`) enabled — this is the
  required dependency, and Facets Pretty Paths in turn needs the Facets module.
- Optionally (since 1.0.0‑alpha3), the **Taxonomy Machine Name**
  (`taxonomy_machine_name`) module, which provides uniqueness for terms from the same
  vocabulary.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_short_pretty_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_short_pretty_paths -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_short_pretty_paths -y
```

Drupal enables Facets Pretty Paths (and Facets) as dependencies if they are not
already on. If you want machine‑name‑based uniqueness for taxonomy terms, also enable
Taxonomy Machine Name:

```bash
drush en taxonomy_machine_name -y
```

## Verify it worked

Set the **Short pretty paths** URL processor on your facet source and browse a
faceted search with several filters active. The URL should now use the compact
dotted form (for example `/color/black.yellow.red`) rather than the longer, repeated
pretty‑paths form.
