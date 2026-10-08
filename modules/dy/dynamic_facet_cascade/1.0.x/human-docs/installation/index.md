# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`).
- **Search API** (`search_api`) with a configured index.
- **Facets** (`facets`), with facet entities attached to your search view's display.
- A **search‑results page built as a Views page display whose base table is your
  Search API index** — the preset form only lists views that satisfy this.
- Typically, **taxonomy vocabularies with entity‑reference fields** linking each
  parent level to its child level (e.g. Make → Model → Version), so the cascade can
  narrow options at each step.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_facet_cascade -W
```

Search API and Facets are separate projects — require them too if they aren't
already present:

```bash
composer require drupal/search_api drupal/facets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_facet_cascade -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_facet_cascade -y
drush cr
```

Clearing caches (`drush cr`) after enabling helps the new block and configuration
pages appear.

## Verify it worked

Go to **Configuration → Search and Metadata → Dynamic Facet Cascade**
(`/admin/config/search/dynamic-facet-cascade`) and confirm the preset‑management page
loads. The real end‑to‑end check comes after you create facets and a preset (see
[Configuration](../configuration/index.md)): place the resulting block above your
search view and confirm the drop‑downs cascade and the search redirect works.
