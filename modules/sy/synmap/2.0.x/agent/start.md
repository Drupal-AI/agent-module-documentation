<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynMap (synmap) — agent index

A small, client-side **single-location map** block using **Yandex Maps**, **Google Maps** or
**OpenStreetMap / Leaflet**. Package `Synapse`. Core requirement `^11 || ^12`. License
GPL-2.0-or-later. Version 2.0.4. No declared module dependencies (uses core `path_alias`,
`language`, `path` services). No entities, no plugins, no permissions of its own, no Drush.

- **The settings form, every config key, routing, the page-attachments hook and JS libraries** →
  [config/settings.md](config/settings.md)

## What it actually is

- One admin form: `Drupal\synmap\Form\Settings` (`src/Form/Settings.php`, form id
  `synmap_settings`), a `ConfigFormBase` editing the single config object **`synmap.settings`**.
  Route **`synmap.settings`** at `/admin/config/synmap`, requirement
  `_permission: 'administer site configuration'` (`synmap.routing.yml`). Menu + local task links
  and `synmap.config_translation.yml` point at that route.
- One service: **`synmap.page_attachments`** → `Drupal\synmap\Hook\PageAttachments`
  (`src/Hook/PageAttachments.php`), invoked from `synmap_page_attachments()` in `synmap.module`
  (`hook_page_attachments`). It decides on which pages the map shows and pushes the map config to
  `drupalSettings['synmap']`.
- Four libraries in `synmap.libraries.yml`: `form` (the admin picker), `map` (front-end map),
  `osm_map` (Leaflet), `yandexmap` (external Yandex API script). JS in `assets/js/`
  (`form.js`, `map.js`, `leaflet.js`) lazy-loads the provider script on scroll.
- Config schema (`config/schema/synmap.schema.yml`) is **partial** — it types only `yamap-name`,
  `map-latitude`, `map-longitude`, `map-zoom`; several stored keys (see settings doc) have no
  schema entry.

## Display logic (from `PageAttachments::hook()`)

`yamap-enable` selects where the map renders: `enable` (all non-`/admin/` pages), `enable_front`
(front page), `enable_contact` (only when current path/alias equals `yamap-path`),
`disable_contact` (all non-admin pages except `yamap-path`), `disable` (off). Other modules can
override the boolean via `hook_synmap_display_alter(&$display, &$attach)`. When language ≠ `ru`
and `yamap-type == 'standart'`, the `synmap/osm_map` (Leaflet) library is also attached.
