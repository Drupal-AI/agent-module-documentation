<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Range Datepicker Widget (facets_range_datepicker_widget) — agent index

Extends the **Facets** module with two widget/processor pairs that render a **date facet as an HTML5 date
picker** — a single-day picker (`datepicker`) or a from/to range picker (`range_datepicker`) — instead of a list
of date links. Package `Search`. License GPL-2.0-or-later. Version **1.0.0-beta5** (pre-release; version-dir
`1.0.x`). Core `>=8.9`.

## Dependencies

- `facets:facets` — provides the widget/processor plugin types (`WidgetPluginBase`, `ProcessorPluginBase`,
  `PreQueryProcessorInterface`, `BuildProcessorInterface`), the URL generator service
  (`facets.utility.url_generator`), and the facet source data definitions this module reads. No composer.json
  ships, so there are no Composer requirements to record.

## What it provides (from source)

- **Two Facets widgets** (`src/Plugin/facets/widget/`):
  - `DatepickerWidget` (id `datepicker`) — one `<input type="date">`, query type `range`, requires the
    `datepicker` processor.
  - `RangeDatepickerWidget` (id `range_datepicker`, **extends** `DatepickerWidget`) — a min + max date input
    pair, requires the `range_datepicker` processor.
  → [plugins/widgets.md](plugins/widgets.md)
- **Two Facets processors** (`src/Plugin/facets/processor/`), each `pre_query`=60 + `build`=20 stage:
  - `DatepickerProcessor` (id `datepicker`) and `RangeDatepickerProcessor` (id `range_datepicker`). `build()`
    injects a placeholder-token filter URL; `preQuery()` parses the picked timestamps back into a min/max range.
  → [plugins/processors.md](plugins/processors.md)
- **One JS library + behavior**: `facets_range_datepicker_widget/datepicker` (`js/datepicker.js`) — reads the
  server-supplied facet URL from `drupalSettings`, substitutes the picked date(s) as UNIX timestamps, and
  redirects the browser. → [behavior/datepicker-js.md](behavior/datepicker-js.md)
- **Config schema** (`config/schema/…`): `facet.widget.config.datepicker` and
  `facet.widget.config.range_datepicker` — the per-facet widget settings (labels + `labels_hidden`).
  → [config/widget-settings.md](config/widget-settings.md)

## What it does NOT provide

No routes, no controllers, no permissions, no forms of its own (only the per-widget `buildConfigurationForm`
rendered inside the Facets facet-edit form), no config objects/`config/install`, no services, no entities, no
Drush, no hooks. `configure` is null.

## Install / operate

1. `composer require drupal/facets_range_datepicker_widget` and `drush en facets_range_datepicker_widget -y`
   (Facets is pulled in / enabled with it).
2. Requires a Facets facet built on a supported date/timestamp field exposed by the facet source (Search API
   index or another facets source).
3. Edit the facet at **Configuration → Search and metadata → Facets** and choose the **Datepicker** or **Range
   Datepicker** widget; also enable the matching **Datepicker** / **Range Datepicker** processor (the widget
   config form shows a warning reminding you to do so).
