<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chart Caption — Views area handler (`chart_caption`)

Everything the module provides. Source: `src/Plugin/views/area/ChartCaption.php` and
`charts_highcharts_caption.module`.

## Install / enable

`drush en charts_highcharts_caption`. Requires `charts` and `charts_highcharts` (declared in
`charts_highcharts_caption.info.yml`; composer `drupal/charts:^5.0`). No install hook, no config to
create — the plugin registers itself. There is **no** admin page.

## How to use (Views UI)

1. Build a View whose **Format** is *Chart*, with the chart **Library set to Highcharts**.
2. In the **Footer** section, add the area handler **"Chart Caption"** (group *Global*).
3. Enter the caption text and set the Highcharts positioning options (below).

Only Highcharts charts get the caption; on any other library the caption is silently ignored.

## Plugin definition

- Class `Drupal\charts_highcharts_caption\Plugin\views\area\ChartCaption` extends
  `Drupal\views\Plugin\views\area\TextCustom`.
- Annotation `@ViewsArea("chart_caption")`.
- Exposed as a Views area via `hook_views_data()`:
  ```php
  $data['charts_highcharts_caption']['table']['group'] = t('Global');
  $data['charts_highcharts_caption']['table']['join']['#global'] = [];
  $data['charts_highcharts_caption']['caption'] = [
    'title' => t('Chart Caption'),
    'help'  => t('Area plugin for a chart caption.'),
    'area'  => ['id' => 'chart_caption'],
  ];
  ```
  The handler must sit in the **footer** and be keyed `caption` for the hooks below to fire (Views
  keys a single instance of a `#global` area by its data key, i.e. `caption`).

## Options (`defineOptions()` / `buildOptionsForm()`)

Inherited from `TextCustom`:
- `content` — the caption text (textarea). HTML permitted.
- `tokenize` — TextCustom's token toggle (see note under "Behavior").

Added by this plugin (Highcharts `caption` properties):

| Option | Form type | Default | Meaning |
|---|---|---|---|
| `align` | select `left`/`center`/`right` | `left` | Horizontal alignment |
| `floating` | checkbox | `FALSE` | Float caption above the plot area |
| `margin` | number | `15` | Margin between caption and plot area |
| `useHTML` | checkbox | `TRUE` | Render caption text as HTML |
| `verticalAlign` | select `top`/`middle`/`bottom` | `bottom` | Vertical alignment |
| `x` | number | `0` | X pixel offset |
| `y` | number | `0` | Y pixel offset |

## Behavior (`charts_highcharts_caption.module`)

- **`hook_chart_definition_alter(array &$definition, array $element, $chart_id)`** — no-ops unless
  `$element['#chart_library'] === 'highcharts'`. If `$element['#view']` is a `ViewExecutable` and its
  display's footer handlers contain `caption` as a `ChartCaption`, it builds:
  ```php
  $caption_config = [
    'text'          => $caption_options['content'] ?? '',
    'align'         => $caption_options['align'] ?? 'left',
    'floating'      => (bool) ($caption_options['floating'] ?? false),
    'margin'        => (int)  ($caption_options['margin'] ?? 15),
    'useHTML'       => (bool) ($caption_options['useHTML'] ?? false),
    'verticalAlign' => $caption_options['verticalAlign'] ?? 'bottom',
    'x'             => (int)  ($caption_options['x'] ?? 0),
    'y'             => (int)  ($caption_options['y'] ?? 0),
  ];
  $definition['caption'] = array_merge($definition['caption'] ?? [], $caption_config);
  ```
  `text` is the **raw stored `content` string** — Views row-token replacement is *not* run on this
  path, so `{{ field }}` tokens are passed through literally rather than substituted.
- **`hook_preprocess_views_view(array &$variables)`** — when `view->style_plugin` is Charts'
  `ChartsPluginStyleChart` and the footer has the `caption` handler, it `unset($variables['footer'])`
  to prevent the caption also rendering as normal footer markup below the chart.

## Config schema / export

Type `charts_highcharts_caption.area.chart_caption` (`type: views_area`) maps: `content` (text),
`tokenize` (boolean), `align` (string), `floating` (boolean), `margin` (integer), `useHTML`
(boolean), `verticalAlign` (string), `x` (integer), `y` (integer). Stored inside the View's
`display.*.display_options.footer.caption.*`, so it moves with the View on config export/import.

## What it does NOT provide

No routes, no permissions.yml, no services.yml, no libraries.yml, no menu links, no Drush, no
install/update hooks, no new plugin type, no submodules.
