<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_statistics` + `bp_stat` bundles

Everything is config in `config/optional/`. No settings form (`configure: null`); the
bundles show up at `/admin/structure/paragraphs_type/bp_statistics` and
`/admin/structure/paragraphs_type/bp_stat`.

## Config objects installed

```
paragraphs.paragraphs_type.bp_statistics                 # outer container, label "Statistics"
paragraphs.paragraphs_type.bp_stat                       # inner item,     label "Stat"

field.storage.paragraph.bp_statistic                     # entity_reference_revisions, cardinality: 4
field.storage.paragraph.bp_statistic_header              # string, max_length 255
field.storage.paragraph.bp_statistic_item                # string, max_length 255
field.storage.paragraph.bp_statistic_description         # string, max_length 255

field.field.paragraph.bp_statistics.bp_statistic         # label "Statistic"  -> targets bp_stat
field.field.paragraph.bp_statistics.bp_header            # parent storage (string)
field.field.paragraph.bp_statistics.bp_width             # parent storage (list_string)
field.field.paragraph.bp_statistics.bp_background        # parent storage (list_string)

field.field.paragraph.bp_stat.bp_statistic_header        # label "Statistic Header"
field.field.paragraph.bp_stat.bp_statistic_item          # label "Statistic"
field.field.paragraph.bp_stat.bp_statistic_description   # label "Statistic Description"

core.entity_form_display.paragraph.bp_statistics.default
core.entity_view_display.paragraph.bp_statistics.default
core.entity_form_display.paragraph.bp_stat.default
core.entity_view_display.paragraph.bp_stat.default
```

`bp_header`, `bp_width`, `bp_background` reuse the storages installed by
**bootstrap_paragraphs**, so their allowed values are shared with every bp_* bundle
(`paragraph--width--{tiny,narrow,medium,wide,full}`; backgrounds such as
`paragraph--color paragraph--color--info`). Read them with
`drush cget field.storage.paragraph.bp_width settings.allowed_values`.

## The nesting field

`field.storage.paragraph.bp_statistic`:

```yaml
type: entity_reference_revisions
settings: { target_type: paragraph }
cardinality: 4          # hard cap — max four stats per Statistics paragraph
translatable: true
```

`field.field.paragraph.bp_statistics.bp_statistic`:

```yaml
settings:
  handler: 'default:paragraph'
  handler_settings:
    negate: 0
    target_bundles:
      bp_stat: bp_stat          # only Stat may be added
    target_bundles_drag_drop:   # every other bp_* bundle listed with enabled: false
      …
```

To allow more than four stats, raise the **storage** cardinality:

```bash
drush php:eval '
  $s = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", "bp_statistic");
  $s->setCardinality(6)->save();
'
```

## Default form displays

`paragraph.bp_statistics.default` — `created`/`status` hidden:

| Field | Widget | Weight |
|---|---|---|
| `bp_background` | `options_select` | 0 |
| `bp_width` | `options_select` | 1 |
| `bp_header` | `string_textfield` | 2 |
| `bp_statistic` | **`entity_reference_paragraphs`** | 3 |

`bp_statistic` widget settings as shipped:

```yaml
title: Stat
title_plural: Stats
edit_mode: closed
add_mode: dropdown
form_display_mode: default
default_paragraph_type: bp_stat
```

`paragraph.bp_stat.default` — all three fields `string_textfield` (size 60), weights
header 0, item 1, description 2; `created`/`status` hidden.

## Default view displays

`paragraph.bp_statistics.default`: `bp_background` and `bp_width` use the **`list_key`**
formatter (prints the raw stored value, which is what the template reads as a CSS class),
`bp_header` uses `string`, and `bp_statistic` uses
`entity_reference_revisions_entity_view` with `view_mode: default`. All labels hidden.

`paragraph.bp_stat.default`: the three string fields with the `string` formatter, labels
hidden, order header → item → description.

## Exposing the bundle to editors

The module attaches nothing to a content type. Add a Paragraphs field and allow the **outer**
bundle only (`bp_stat` is reachable through `bp_statistic`, never directly):

```bash
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  FieldStorageConfig::create([
    "field_name" => "field_page_sections", "entity_type" => "node",
    "type" => "entity_reference_revisions", "cardinality" => -1,
    "settings" => ["target_type" => "paragraph"],
  ])->save();
  FieldConfig::create([
    "field_name" => "field_page_sections", "entity_type" => "node",
    "bundle" => "article", "label" => "Sections",
    "settings" => [
      "handler" => "default:paragraph",
      "handler_settings" => ["target_bundles" => ["bp_statistics" => "bp_statistics"]],
    ],
  ])->save();
'
```

## Building the nested structure programmatically

Create the inner `bp_stat` paragraphs first, then reference them from the outer one:

```php
use Drupal\paragraphs\Entity\Paragraph;

$stats = [];
foreach ([['Uptime', '99.98%', 'Last 12 months'],
          ['Customers', '4,200', 'Across 30 countries'],
          ['Response', '< 2h', 'Median first reply']] as [$h, $i, $d]) {
  $s = Paragraph::create([
    'type' => 'bp_stat',
    'bp_statistic_header' => $h,
    'bp_statistic_item' => $i,
    'bp_statistic_description' => $d,
  ]);
  $s->save();
  $stats[] = $s;
}

$band = Paragraph::create([
  'type' => 'bp_statistics',
  'bp_header' => 'By The Numbers',
  'bp_width' => 'paragraph--width--wide',
  'bp_background' => 'paragraph--color paragraph--color--info',
  'bp_statistic' => $stats,          // max 4
]);
$band->save();
$node->set('field_page_sections', [$band])->save();
```

Read it back:

```php
$band->get('bp_statistic')->referencedEntities()[0]->get('bp_statistic_item')->value;
```

## Uninstall note

The config is `optional`, not `install` — `drush pmu bp_statistics` leaves both paragraph
types and all their fields in place. Delete them by hand if you want them gone.
