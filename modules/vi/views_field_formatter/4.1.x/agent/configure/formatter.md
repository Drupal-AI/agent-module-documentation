<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "View" field formatter

Set any field's formatter to **View** on the entity's *Manage display* page, or in the
`entity_view_display` config. There is no module settings page.

## Formatter plugin

- id: `views_field_formatter`, label "View", weight 100
- available on almost all field types (boolean, string, entity_reference, list_*, integer,
  decimal, float, datetime, link, image, file, text, uri, uuid, …)

## Settings (schema `field.formatter.settings.views_field_formatter`)

| key | type | meaning |
|---|---|---|
| `view` | string | the view + display as `"<view_id>::<display_id>"`, e.g. `frontpage::page_1` |
| `arguments` | map | per available argument: `{checked: bool, weight: int}` — which contextual args to send and their order |
| `hide_empty` | bool | render nothing if the embedded view returns no output |
| `multiple` | bool | for multi-value fields, render the view once per value (else once) |
| `implode_character` | string | when `multiple`, the character joining per-value outputs |

`defaultSettings()`: `view => ''`, `arguments => [...]`, `hide_empty => FALSE`,
`multiple => FALSE`.

## How it renders

`viewElements()` splits `view` on `::` into `[view_id, display_id]` and builds a
`#type => 'view'` render element for each item (or once, per `multiple`), passing the selected
`arguments` (field delta, the field value, the host entity id, …) as the view's contextual
arguments. The formatter's `calculateDependencies()` adds a config dependency on the chosen
view, so exports stay consistent.

## Configure in config (drush)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_tags', [
  'type' => 'views_field_formatter',
  'weight' => 10, 'region' => 'content', 'label' => 'hidden',
  'settings' => [
    'view' => 'frontpage::page_1',
    'arguments' => [],
    'hide_empty' => TRUE,
    'multiple' => FALSE,
    'implode_character' => '',
  ],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_tags
# type: views_field_formatter ; settings.view: frontpage::page_1
```

The formatter's summary (`settingsSummary()`) prints the chosen view, whether multiple is
enabled, whether empty results are hidden, and the selected arguments.
