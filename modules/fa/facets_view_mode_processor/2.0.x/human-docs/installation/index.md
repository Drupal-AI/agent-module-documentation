# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Facets** module — Composer accepts `drupal/facets ^2.0 || ^3.0`, so it works
  with both current Facets majors.
- A facet built on an **entity‑reference field**, and a suitable **view mode** on the
  referenced entity type to render items through.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_view_mode_processor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it will pull in a compatible version of Facets.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets_view_mode_processor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_view_mode_processor -y
```

If Facets is not already enabled, Drupal enables it as a dependency.

## Verify it worked

Edit an entity‑reference facet at **Configuration → Search and metadata → Facets** and
open its **processors** section. You should see **Transform entity ID to view mode**
available, with a view‑mode selector. Enable it, pick a view mode, save, and confirm
the facet items now render through that view mode on the search page.
