# Configure the Bootstrap Utilities filters

The module adds four filter plugins to core's Filter system. There is no dedicated settings page
(`configure: null`); you enable them **per text format** at *Configuration → Content authoring →
Text formats and editors* (`/admin/config/content/formats/manage/<format>`), in the "Enabled
filters" list.

## The filters

| Filter plugin id | Label | Class(es) added | Settings |
|---|---|---|---|
| `bootstrap_utilities_table_filter` | Bootstrap Utilities - Table Classes | `table` on `<table>` (+ optional variants) | yes (below) |
| `bootstrap_utilities_image_filter` | Bootstrap Utilities - Responsive Image Class | `img-fluid` on `<img>` | none |
| `bootstrap_utilities_blockquote_filter` | Bootstrap Utilities - Blockquote Classes | `blockquote` on `<blockquote>` | none |
| `bootstrap_utilities_figure_filter` | Bootstrap Utilities - Figure Classes | `figure` on `<figure>`, `figure-caption` on `<figcaption>` | none |

Each merges its class into any existing `class` attribute (existing classes are kept). They run at
output/render time via xPath, and are `TYPE_TRANSFORM_IRREVERSIBLE` — place them after tag-limiting
filters in the filter order.

## Table filter settings

Config schema `filter_settings.bootstrap_utilities_table_filter`. Defaults in the plugin:

| Setting | Default | Effect |
|---|---|---|
| `table_remove_width_height` | `TRUE` | Remove `width`/`height` attributes from `<tbody>` cells (responsive). |
| `table_row_striping` | `FALSE` | Add `table-striped`. |
| `table_bordered` | `FALSE` | Add `table-bordered`. |
| `table_row_hover` | `FALSE` | Add `table-hover`. |
| `table_small` | `FALSE` | Add `table-sm`. |

(The always-added `table` class is not a setting.)

## Config shape (`filter.format.<format_id>`)

```yaml
filters:
  bootstrap_utilities_image_filter:
    id: bootstrap_utilities_image_filter
    status: true
    weight: 20
    settings: {}
  bootstrap_utilities_table_filter:
    id: bootstrap_utilities_table_filter
    status: true
    weight: 21
    settings:
      table_remove_width_height: true
      table_row_striping: true
      table_bordered: false
      table_row_hover: false
      table_small: false
```

## Enable a filter programmatically

```php
$format = \Drupal\filter\Entity\FilterFormat::load('full_html');
$format->setFilterConfig('bootstrap_utilities_image_filter', ['status' => TRUE, 'weight' => 20]);
$format->setFilterConfig('bootstrap_utilities_table_filter', [
  'status' => TRUE, 'weight' => 21,
  'settings' => ['table_row_striping' => TRUE, 'table_remove_width_height' => TRUE],
]);
$format->save();
```

## Read it back

```bash
drush cget filter.format.full_html filters.bootstrap_utilities_table_filter
```
