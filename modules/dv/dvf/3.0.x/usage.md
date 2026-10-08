<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Generates data visualisations (charts and tables) from external data sources without custom code.
- Provides field types/widgets so editors attach a data source (file or URL) to content and pick a chart style.
- Ships style plugins for bar, line, pie, donut, scatter, bubble, radar, gauge, spline and table outputs, with CSV, JSON and CKAN source submodules.

---

## Install & configure

- Enable `dvf` plus the source submodule(s) you need: `dvf_csv`, `dvf_json`, and/or `dvf_ckan`.
- Add a "Visualisation (File)" or "Visualisation (URL)" field to a content type via Field UI.
- Editors then upload a data file or enter a data URL and choose a visualisation style per field value.

---

## Usage & behaviour

- Two field types are provided: `dvf_file` (uploaded data file) and `dvf_url` (remote data URL); each is rendered by a chart style plugin at display time.
- `VisualisationSourceBase::getContentFromUri()` fetches the configured source server-side: local stream wrappers via `file_get_contents()`, otherwise `httpClient->get($uri)` (Guzzle, TLS verification on).
- No `verify=>false` is used anywhere; TLS is left at safe Guzzle defaults.
- The only route is `/dvf/help/{topic}` (help pages), gated by the core `access content overview` permission — informational only, no data mutation.
- Fetched data is cached with a configurable expiry (falls back to the site's page cache max-age).
- Chart rendering is client-side JS fed by the server-parsed dataset; templates autoescape labels.
- Use it for open-data dashboards, statistics pages, and report visualisations sourced from CKAN portals or spreadsheets.
- CKAN integration includes migrate process/source plugins for importing CKAN datasets.
- Field widgets expose per-visualisation options (axis, colors, keys) configurable by editors.
- Because sources are re-fetched, a slow/hostile remote URL can delay rendering; the cache expiry mitigates repeat hits.
- Local file sources are limited to registered local stream wrappers, not arbitrary paths.
- Works with Views and standard field display, so visualisations appear like any formatted field.
- The framework is extensible: add custom `@Visualisation`, `@VisualisationStyle`, and `@VisualisationSource` plugins.
- Clear caches after adding submodules so new source/style plugins are discovered.
- Test large datasets for memory/time limits, since the whole source is read into memory before charting.
