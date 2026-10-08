# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Facets** module — Composer accepts `drupal/facets ^2.0 || ^3.0`, so it works
  with both current Facets majors.
- A working faceted search with at least one facet built on a **taxonomy term
  field**; the processors apply only to taxonomy fields.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_taxonomy_multilevel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it will pull in a compatible version of Facets.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_taxonomy_multilevel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_taxonomy_multilevel -y
```

If Facets is not already enabled, Drupal enables it as a dependency.

## Verify it worked

Edit a taxonomy‑based facet at **Configuration → Search and metadata → Facets** and
open its **processors** section. You should see **Show terms of defined depth** and
**Show terms based on Dependee Facet** available to enable. Turning one on and
reloading the search page confirms the module is active.
