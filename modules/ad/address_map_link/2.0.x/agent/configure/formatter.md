<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and configure the map link on an address field

No configure route (`configure: null`). You configure it per address field, per view mode, on the
bundle's **Manage display** page (or directly in the `entity_view_display` config). The settings appear
in the formatter settings for a field of type `address` only.

## Settings (third-party settings on the formatter)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `link_address` | boolean | `FALSE` | Master switch — turn the address into a map link. |
| `map_link_type` | string (plugin id) | `google_maps` | Which MapLink provider to use. |
| `map_link_position` | string | `address` | `address` (link the address text), `before`, or `after`. |
| `map_link_text` | string | `Open Map` | Link text (used for `before`/`after`; supports tokens if Token is enabled). |
| `map_link_new_window` | boolean | `FALSE` | Add `target="_blank"`. |

Provider ids for `map_link_type`: `google_maps`, `google_maps_directions`, `apple_maps`, `bing_maps`,
`here_wego_maps`, `mapquest`, `openstreetmap`, `yandex_maps`, `waze_directions`, `waze_navigate`.

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_address:
    type: address_default          # the Address module formatter
    third_party_settings:
      address_map_link:
        link_address: true
        map_link_type: google_maps_directions
        map_link_position: after
        map_link_text: 'Get directions'
        map_link_new_window: true
```

Config schema: `field.formatter.third_party.address_map_link` (see `config/schema`).

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. Click the gear on the Address field row.
3. Tick **Link Address to Map**, pick the **Map Link Type**, set position / text / new-window.
4. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_address');            // must be an address field with an address formatter
$c['third_party_settings']['address_map_link'] = [
  'link_address' => TRUE,
  'map_link_type' => 'google_maps_directions',
  'map_link_position' => 'after',
  'map_link_text' => 'Get directions',
  'map_link_new_window' => TRUE,
];
$vd->setComponent('field_address', $c)->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_address`.
