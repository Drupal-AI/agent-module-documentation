<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Fields Search (entitytype_filter) — agent index

Admin utility that lists the **configurable fields** on a site's bundles. Two admin pages: search
one bundle's fields by title, or list fields across all bundles of an entity type (with CSV export).
No config, no own permissions, no content model. Core `^8 || ^9 || ^10 || ^11`. Version 3.0.0.
GPL-2.0-or-later. Package: none declared. `info.yml` name is "Entity Fields Search".

## What it actually is (from source)

- **Two forms**, each reached through `SearchEntitiesController` (`src/Controller/SearchEntitiesController.php`):
  - `FilterEntityTypesForm` (route `entitytype_filter.list_fields`, path `/admin/entitytypes-filter`) —
    pick a bundle config entity type, autocomplete one bundle by title, AJAX-list its configurable fields.
  - `FilterFieldTypesForm` (route `entitytype_filter.list_fields_by_type`, path `/admin/fieldtypes-filter`) —
    list configurable fields across all bundles of a chosen entity type, optionally filtered by field
    type; client-side CSV export.
  - Both routes require permission **`administer content`**. Menu links under *Content* (`system.admin_content`).
- **One autocomplete controller** `EntitiesAutoCompleteController::handle` (route `entitytype_filter.autocomplete`,
  `_format: json`, permission `administer content`) — bundle-title typeahead for the first form.
- **One helper service** `entitytype_filter.search_service` → `EntitySearchService` (core deps only).
- **No** `.permissions.yml`, `.install`, `config/`, config schema, plugins, hooks, or Drush.
- Two front-end libraries in `entitytype_filter.libraries.yml` (`filter_field`, `filter_fields_by_type`);
  CSV export is pure browser JS (`js/filter_fields_by_type.js`).

## Solution docs

- **Forms, routes, permissions, autocomplete, CSV export, how to operate** →
  [forms/search-forms.md](forms/search-forms.md)
- **`EntitySearchService` helper API (bundle discovery, grouped field types, field-type label lookup)** →
  [api/entity-search-service.md](api/entity-search-service.md)
