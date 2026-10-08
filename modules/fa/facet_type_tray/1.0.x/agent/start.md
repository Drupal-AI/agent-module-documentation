<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facet Type Tray (facet_type_tray) — agent index

Bridge module that exposes **Type Tray** content-type category groupings as a **Search API** /
**Facets** facet. It indexes each node's Type Tray category (parent key + compound `category.bundle`
child value), resolves those raw values to labels, orders them by the Type Tray category order, and
offers a two-level category→bundle hierarchy. Package `Custom`. License GPL-2.0-or-later.
Version 1.0.0. Core `^10 || ^11`.

## Dependencies

- `search_api:search_api` — index + processor framework. Composer `drupal/search_api:^1.40`.
- `facets:facets` — the facet, its build/sort processor and hierarchy plugin types. Composer `drupal/facets:^3.0`.
- `type_tray:type_tray` — supplies the categories: node-type third-party setting
  `type_tray.type_category` and the ordered `type_tray.settings` `categories` map. Composer `drupal/type_tray:^1.3`.

## What it provides (from source — four plugins)

- **Search API processor** `type_tray` — `src/Plugin/search_api/processor/TypeTrayProcessor.php`
  (`#[SearchApiProcessor]`, stage `add_properties`). Adds one `type_tray` string property ("Type Tray
  category") and, per node, indexes the category key plus a `category.bundle` compound value.
  → [plugins/search-api-processor.md](plugins/search-api-processor.md)
- **Facets build processor** `type_tray` ("Type Tray: Merge node types") —
  `src/Plugin/facets/processor/TypeTrayProcessor.php` (stage `build` 80). Sets each result's display
  value to a readable label. → [plugins/facets-build-processor.md](plugins/facets-build-processor.md)
- **Facets sort processor** `type_tray_category` ("Sort by Type Tray categories") —
  `src/Plugin/facets/processor/TypeTrayOrderProcessor.php` (stage `sort` 40). Orders results by the
  `type_tray.settings` category order. → [plugins/facets-sort-processor.md](plugins/facets-sort-processor.md)
- **Facets hierarchy** `type_tray` ("Type Tray hierarchy") —
  `src/Plugin/facets/hierarchy/TypeTrayHierarchy.php`. Parent = category, child = `category.bundle`.
  → [plugins/facets-hierarchy.md](plugins/facets-hierarchy.md)

## What it does NOT provide

No routes, controllers, permissions, forms, services, hooks, `config/install`, **config schema**,
entities, or Drush. `configure` is null. Everything is set up on the Search API index and on the
facet in the Facets/Search API admin UI.

## Install / operate

1. `composer require drupal/facet_type_tray` (pulls search_api, facets, type_tray).
2. `drush en facet_type_tray -y`.
3. Assign Type Tray categories to content types (types without one index under their machine name).
4. On the Search API index → **Processors**, enable **Type Tray**, then re-index.
5. Add a facet for the new **Type Tray category** field; enable the **Type Tray: Merge node types**
   build processor, optionally the **Sort by Type Tray categories** sort processor, and (for two
   levels) the **Type Tray hierarchy** plugin with a hierarchy-capable widget.
