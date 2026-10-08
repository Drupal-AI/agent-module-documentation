<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts Highcharts Caption (charts_highcharts_caption) — agent index

A one-plugin Charts add-on: a **Views area handler** that turns a View-footer text area into the
native **Highcharts `caption`** drawn inside the chart. Package `Charts`. Depends on **`charts`**
and **`charts_highcharts`** (Charts ^5.0). Core `^8.8 || ^9 || ^10 || ^11`. GPL-2.0-or-later.
Version 1.0.2. **No settings page, no route, no permission, no service, no Drush.**

- **The area plugin, its options, the hooks, and how to operate it** →
  [views/chart_caption.md](views/chart_caption.md)

## What it actually is

- One Views area plugin: `ChartCaption` (id **`chart_caption`**, label *"Chart Caption"*), in
  `src/Plugin/views/area/ChartCaption.php`, extending core Views' **`TextCustom`** custom-text area.
  It adds Highcharts caption options on top of the inherited `content`/`tokenize` textarea.
- Registered by `hook_views_data()` in `charts_highcharts_caption.module` as area `chart_caption`
  under the `#global` table `charts_highcharts_caption` (group *Global*, handler key **`caption`**),
  so it appears in the **footer** handler list of any View.
- Config schema **`charts_highcharts_caption.area.chart_caption`** in
  `config/schema/charts_highcharts_caption.area.schema.yml`.

## Mechanism (from source, `charts_highcharts_caption.module`)

- `hook_chart_definition_alter(&$definition, $element, $chart_id)`: returns early unless
  `$element['#chart_library'] === 'highcharts'`; then if the View has a **footer** handler keyed
  `caption` that is a `ChartCaption`, it reads that handler's `->options` and merges a
  `caption_config` (`text` = `options['content']`, plus `align`, `floating`, `margin`, `useHTML`,
  `verticalAlign`, `x`, `y`, cast to bool/int) into `$definition['caption']`.
- `hook_preprocess_views_view(&$variables)` (`..._preprocess_views_view`): when the View's style is
  Charts' `ChartsPluginStyleChart` and the footer has the `caption` handler, it **`unset($variables['footer'])`**
  so the caption is not also printed as ordinary footer HTML.

## Plugin options (defaults, `defineOptions()`)

Inherited from `TextCustom`: `content` (the caption text), `tokenize`. Added here:
`align` (`left`), `floating` (`FALSE`), `margin` (`15`), `useHTML` (`TRUE`), `verticalAlign`
(`bottom`), `x` (`0`), `y` (`0`). Form built in `buildOptionsForm()`. Details + a config example in
[views/chart_caption.md](views/chart_caption.md).

## Notes

- Highcharts-only by design: the alter no-ops for any other chart library, so it is inert on charts
  rendered by google/chartjs/etc.
- The caption text is a **Views "Custom text" area** — editable only by users with the Views
  administration permission, i.e. trusted site builders (same trust level as any other Views markup).
- `text` is taken from the **raw stored `content`** template; row-token substitution is not applied
  through this path.
