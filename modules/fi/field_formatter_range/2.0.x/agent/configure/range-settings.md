<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure range / order / offset on a field formatter

No settings page (`configure: null`). You configure it **per field, per view mode**, on the
entity bundle's *Manage display* page, or directly in the `entity_view_display` config.

## Where it is stored

Config entity: `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: <any formatter>            # e.g. string, entity_reference_label, image
    third_party_settings:
      field_formatter_range:
        order: 1                     # 0 Default, 1 Reverse, 2 Random
        limit: 2                     # "Display items" — number to show, 0 = all
        offset: 1                    # "Skip items" — number to skip from the start
```

The settings group is **only offered when the field's cardinality is not 1**. On a single-value
field the range has no meaning and nothing is added (and it has no effect if set).

Config schema key: `field.formatter.third_party.field_formatter_range` — three integers
`order`, `limit`, `offset`.

## Settings meaning

| Setting | UI label | Values |
|---|---|---|
| `order` | Order | 0 = Default, 1 = Reverse, 2 = Random |
| `limit` | Display items | integer; `0` = display all (min 0; max = cardinality, or 100 for unlimited) |
| `offset` | Skip items | integer ≥ 0; items skipped from the beginning |

Render logic (`hook_preprocess_field`): reverse (order 1) or shuffle (order 2) the items, then
`array_slice($items, $offset, $limit ?: NULL)`, then re-index deltas from 0. Applied only when
at least one of order/offset/limit is set.

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. Click the cog on a **multi-value** field's row.
3. Open the **Field Formatter Range** details: pick an **Order**, set **Display items**
   (limit) and **Skip items** (offset).
4. **Update**, then **Save**. The summary shows e.g. "Display 2 items in reversed order. Offset by 1."

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$component = $vd->getComponent('field_gallery');   // must be a multi-value field
$component['third_party_settings']['field_formatter_range'] = [
  'order' => 1, 'limit' => 2, 'offset' => 0,
];
$vd->setComponent('field_gallery', $component)->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_gallery
# look for third_party_settings.field_formatter_range.{order,limit,offset}
```

## Notes / gotchas

- Historic key rename: pre-2.x stored a boolean `reverse`; update 9101 converts it to
  integer `order` (`FieldFormatterRangeUpdater`). New config uses `order`.
- To disable, set `order`, `limit`, and `offset` all to 0 (or remove the
  `field_formatter_range` third-party settings key) and save.
- Works the same for Layout Builder component formatters (settings live under the component's
  `configuration.formatter.third_party_settings.field_formatter_range`).
