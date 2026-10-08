<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Location (localgov_directories_location) — agent index

Submodule of [localgov_directories](../../../../3.5.x/agent/start.md) adding location fields, maps
and proximity search. Unlike the entry-type submodules this one contains real logic.

Key facts:
- Dependencies: `localgov_directories`, `localgov_geo:localgov_geo_address`,
  `leaflet:leaflet_views`, `search_api_location:search_api_location_views`,
  `search_api_location:search_api_location_geocoder`, `inline_entity_form`.
- Field storages installed: **`localgov_location`** (geo entity reference — the field venue and
  organisation bundles attach) and **`localgov_proximity_search_cfg`** (per-channel proximity
  configuration). The indexed location datatype field is `localgov_location_wkt`
  (`Constants::LOCATION_FIELD_WKT`).
- **`ProximitySearchSetup`** is the workhorse: called from `hook_field_config_insert()` when the
  location field lands on a bundle, and from `hook_search_api_index_update()`. It adds the location
  field to the Search API index with the `location` datatype
  (`Constants::SEARCH_API_LOCATION_DATATYPE`), enables the channel view's
  `node_embed_for_proximity_search` and `embed_map` displays, and applies the parent module's
  conditional facet config `facets.facet.localgov_directories_facets_proximity_search`.
- `LocationExtraFieldDisplay` + `hook_entity_extra_field_info()` / `hook_ENTITY_TYPE_view()` render
  the location as a pseudo-field on entries.
- `EventSubscriber/SearchApiSubscriber` handles indexing-time location concerns.
- `config/override/` adjusts the parent's `views.view.localgov_directory_channel` and the
  `localgov_directory` form display for the location-enabled case; `config/conditional/` holds the
  proximity config field instance.

Gotchas:
- Enabling this module alone does nothing visible — a bundle must actually have the
  `localgov_location` field (the venue/org submodules add it) before the setup hooks fire.
- After adding the field to a custom bundle, reindex:
  `drush search-api:index localgov_directories_index_default`.
- Geocoding requires `search_api_location_geocoder` to be configured with a geocoder provider;
  without it addresses are stored but never resolve to coordinates.
