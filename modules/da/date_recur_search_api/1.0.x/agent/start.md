<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recurring Dates Field Search API (date_recur_search_api) — agent index

Search API integration for **Recurring Dates Field (date_recur)**. For every `date_recur` field it derives a
Search API datasource ("Date occurrences") that indexes each recurrence occurrence as its own item, expanded up
to a configurable point in the future. A hidden computed date-range field carries the single occurrence date for
sorting/filtering/display. No routes, no permissions, no services beyond one event subscriber.

- **Requires:** `date_recur`, `search_api`, `datetime_range` (core), `computed_field` (>=4.0.0). Core `^10 || ^11`.
  Package `Search`. License GPL-2.0-or-later. Recommends `search_api_common_field`.
- **Configuration:** per-datasource, on the Search API index form (config schema
  `plugin.plugin_configuration.search_api_datasource.date_recur:*`). No global settings route.

## What it provides

- **Datasource plugin** `date_recur` (`src/Plugin/search_api/datasource/DateRecur.php`), extending Search API's
  core `ContentEntity` datasource, with a deriver producing one derivative per `date_recur` field.
- **Deriver** `DateRecurDatasourceDeriver` (`src/Plugin/Deriver/`) — derivative id `<entity_type>__<field_name>`.
- **Computed field plugin** `date_recur_date_occurrence` (`src/Plugin/ComputedField/DateOccurrence.php`) — a
  `no_ui` `daterange` field attached as `<field>_occurrence` to every bundle that has a `date_recur` field.
- **Event subscriber** `SearchApiTrackerSubscriber` (`src/EventSubscriber/`) — keeps the Search API tracker in
  sync on date_recur `FIELD_VALUE_SAVE` / `FIELD_ENTITY_DELETE` events. Service
  `date_recur_search_api.search_api_tracker_subscriber`.
- **Hook** `hook_entity_build_defaults_alter()` (`.module`) — adds per-occurrence render-cache keys.

## Solution docs

- [Date occurrences datasource](datasources/date_recur.md) — the datasource, its config (pre_create, bundles,
  languages), item-ID scheme, `getItemIds()`/`loadMultiple()`, and how to set it up on an index.
- [Computed field, tracker & caching](plugins/computed-field.md) — the `<field>_occurrence` computed field,
  the tracker event subscriber, the deriver, and the render-cache hook.
