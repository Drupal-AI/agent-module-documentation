<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Text Filter (charts_text_filter) — agent index

A CKEditor 5 button plus a text filter that let editors embed **Charts-module charts** inline in
rich text. The button stores a chart as a `<chart data-chart-config="{JSON}">` element; the filter
`filter_charts_text_filter` renders those elements on output via `Chart::buildElement`. Package
`Charts`. Depends on **`charts`** (`^5.1`) and core **`ckeditor5`**, **`editor`**, **`filter`**.
Core requirement `^10.5 || ^11 || ^12`. License GPL-2.0-or-later. Version 2.0.0.

- **The filter, the CKEditor 5 button, the dialog form and the config JSON round-trip** →
  [plugins/filter-and-button.md](plugins/filter-and-button.md)
- **`ChartConfig` encode/decode/clean/mergeDefaults + the AJAX insert command** →
  [api/chart-config.md](api/chart-config.md)

## What it actually is

- **Filter plugin** `ChartsTextFilter` (id **`filter_charts_text_filter`**, type
  `TYPE_TRANSFORM_IRREVERSIBLE`), `src/Plugin/Filter/ChartsTextFilter.php`. `process()` renders
  embedded charts on display; injects the `renderer` service.
- **CKEditor 5 plugin** `ChartButton` (id **`charts_text_filter_button`**),
  `src/Plugin/CKEditor5Plugin/ChartButton.php`. Adds toolbar item `insertChart`, allows elements
  `<chart>` / `<chart data-chart-config>`, and is **conditioned on the `filter_charts_text_filter`
  filter being enabled**. Exposes the dialog URL to JS via `getDynamicPluginConfig()`.
- **Dialog form** `ChartConfigForm` (`@internal`), `src/Form/ChartConfigForm.php` — the modal that
  builds the Charts `charts_settings` element and hands config back to the editor over AJAX. No
  server-side persistence.
- **Utility** `ChartConfig` (`src/Utility/ChartConfig.php`) — JSON encode/decode/clean/merge of the
  chart config. **AJAX command** `InsertChartCommand` (`src/Ajax/InsertChartCommand.php`).
- One route: **`charts_text_filter.dialog`** at `/charts-text-filter/dialog/{editor}`, gated by
  `_entity_access: 'editor.use'` (`charts_text_filter.routing.yml`).
- Asset libraries in `charts_text_filter.libraries.yml`: `charts_button`, `charts_command`, `admin`
  (CKEditor build + AJAX command JS + placeholder CSS). No config schema, no permissions, no
  `.module`, no install hooks, no Drush.

## Mechanism (from source)

- Editor clicks the Chart button → CKEditor 5 plugin opens `charts_text_filter.dialog` in a modal →
  `ChartConfigForm` renders `#type => 'charts_settings'` seeded from `charts.settings`
  `charts_default_settings` (merged with any existing chart config). Submit is AJAX-only
  (`submitFormAjax`): it cleans the values (`ChartConfig::clean`) and returns an `InsertChartCommand`
  carrying the JSON config keyed by `dialogId`; `js/charts-ajax-command.js` routes it to the right
  editor instance, which writes `<chart data-chart-config="{JSON}">` into the markup.
- On display, `ChartsTextFilter::process()` short-circuits unless the text contains `<chart`, then
  uses `Html::load()` + XPath `//chart[@data-chart-config]`, decodes each attribute
  (`ChartConfig::decode`), skips configs missing `type`/`library`/`display`, builds
  `Chart::buildElement($config, $id)`, renders it in an isolated `RenderContext`, merges bubbled
  cacheability + attachments into the `FilterProcessResult`, and replaces the `<chart>` node with the
  rendered markup (`Html::serialize`).

## Trust model / notes

- The chart configuration is **authored content**: it is produced by an editor with access to the
  text format and rendered through the standard Charts render element inside Drupal's render
  pipeline. Enable the filter/button only on text formats intended for trusted editors — the same
  trust boundary as any rich-text filter.
- The dialog route is access-controlled by the editor entity's `use` access
  (`\Drupal\editor\EditorAccessControlHandler`), covered by `tests/src/Functional/ChartDialogAccessTest.php`.
- The filter fetches nothing over the network, reads no files/entities, runs no queries, and stores
  no configuration of its own.
