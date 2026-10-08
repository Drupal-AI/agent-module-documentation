# Views area button (`printjs_views_btn`)

`Drupal\printjs\Plugin\views\area\PrintjsViewsBtn` — a `#[ViewsArea("printjs_views_btn")]` handler
extending `TokenizeAreaPluginBase`. Registered by `hook_views_data()` in `printjs.module`:

```php
$data['views']['area_printjs_views'] = [
  'title' => t('PrintJs'),
  'help'  => t('Print button'),
  'area'  => ['id' => 'printjs_views_btn'],
];
```

Add it in the Views UI under **Header** or **Footer** → *Add* → **"PrintJs"** (a global/area
handler, so it appears for any view). It prints the view's results region.

## Options (`buildOptionsForm` / `defineOptions`)

Same option set as the block, seeded from the global `printjs.settings` object in `defineOptions()`
(so a view starts from the site defaults, then can override):

| Option | Type | Default source |
|--------|------|----------------|
| `printjs_id` | textfield | `printjs.settings:printjs_id` (hint: e.g. `.view-id-<id>`) |
| `printText` | textfield (required) | `Print` |
| `auto_print` | checkbox | `printjs.settings:auto_print` |
| `print_parent_selector` | checkbox | `printjs.settings:print_parent_selector` |
| `local` | checkbox | `printjs.settings:local` |

## Render

`render($empty = FALSE)` resolves the effective options (from `$this->view->{$areaType}
['area_printjs_views']->options` when present, else `$this->options`) and returns
`\Drupal::service('print.js')->getBtnPrintjs($this->options['printText'], $config)` — i.e. the same
button render array as the block and the service. `TokenizeAreaPluginBase` allows Views tokens in the
area, though the option values here are the print selector/label rather than free text.
