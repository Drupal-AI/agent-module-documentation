<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ChartConfig utility & InsertChartCommand

The single representation of an embedded chart's configuration as it moves between the editor, the
dialog form and the filter. Source: `src/Utility/ChartConfig.php`, `src/Ajax/InsertChartCommand.php`,
`js/charts-ajax-command.js`.

## `ChartConfig` (final, non-instantiable)

The chart's configuration is stored as JSON in the `data-chart-config` attribute of a `<chart>`
element. All static methods:

- `decode(?string $json): array` — **never throws**. Empty/NULL → `[]`; `json_decode(...,
  JSON_THROW_ON_ERROR)` inside a try/catch; on `\JsonException` returns `[]`; a non-array decode also
  returns `[]`. This tolerates hand-edited source-view input.
- `encode(array $config): string` — `json_encode` with `JSON_THROW_ON_ERROR |
  JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE`. Throws `\JsonException` on failure.
- `clean(array $config): array` — recursively strips form-artifact keys before storing: constant
  `REMOVE_KEYS` = `delete_column`, `weight`, `operations`, `_weight`, `_delete_column_buttons`,
  `_operations` (added by the `charts_settings` tabledrag / data-collector widgets, meaningless once
  rendered).
- `mergeDefaults(array $defaults, array $config): array` — merges a saved chart's config **over** the
  site defaults. Deliberately **not** `NestedArray::mergeDeep()`: list arrays (`array_is_list`) are
  taken verbatim from the chart (so data series / color lists do not grow on each edit); only
  associative sub-arrays present in both are merged recursively (so a setting that did not exist when
  the chart was embedded still picks up its default).

## `InsertChartCommand` (AJAX command)

- Constructed with `array $chartConfig` and `string $dialogId` (both `readonly`).
- `render()` returns `['command' => 'chartsTextFilterInsertChart', 'dialogId' => $this->dialogId,
  'chartConfig' => ChartConfig::encode($this->chartConfig)]` — it carries the **config JSON, not
  markup**; the CKEditor 5 plugin owns the widget presentation and decides insert-vs-replace.

## Client side (`js/charts-ajax-command.js`)

- Registers `Drupal.AjaxCommands.prototype.chartsTextFilterInsertChart`. A `Drupal.chartsTextFilter`
  namespace holds a `callbacks` Map keyed by `dialogId`; the handler looks up the callback for
  `response.dialogId`, deletes it, and invokes it with `response.chartConfig`. Keying by dialog id
  lets a page with several editors return each config to the editor that requested it.

## Round-trip summary

editor button → dialog form (`charts_settings` seeded from `charts.settings` defaults) → submit →
`ChartConfig::clean` → `InsertChartCommand` (`ChartConfig::encode`) → JS callback writes
`<chart data-chart-config="{JSON}">` → on display `ChartsTextFilter::process()` →
`ChartConfig::decode` → `Chart::buildElement` → rendered chart.
