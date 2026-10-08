<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Entity Browser widget on a Custom Field reference column

## Prerequisite

The Custom Field must have an `entity_reference` **column** in its storage `columns`
setting, with a `target_type` (e.g. `node`):

```php
'settings' => ['columns' => [
  'ref' => ['name' => 'ref', 'type' => 'entity_reference', 'target_type' => 'node'],
]],
```

## Select the widget (form display)

On the bundle's *Manage form display*, the `entity_reference` column can choose the
**Entity browser** widget. In config this is the per-column widget `type` on the Custom
Field's base-widget component:

```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'cfeb_eval', 'default');
$fd->setComponent('field_cfeb_ref', [
  'type' => 'custom_flex', 'region' => 'content', 'weight' => 5,
  'settings' => ['fields' => [
    'ref' => [
      'type' => 'entity_reference_entity_browser',
      'entity_browser' => 'my_browser',        // an entity_browser config entity id
      'field_widget_display' => 'label',        // default
      'open' => FALSE,
      'field_widget_edit' => TRUE,
      'field_widget_remove' => TRUE,
      'field_widget_replace' => FALSE,
    ],
  ]],
])->save();
```

## Settings keys (added to `custom_field.field.*` schema)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `type` | string | — | must be `entity_reference_entity_browser` |
| `entity_browser` | string | `NULL` | id of the Entity Browser instance to open |
| `field_widget_display` | string | `label` | how selected entities render (`label`, `rendered_entity`, …) |
| `field_widget_display_settings` | mapping | `[]` | settings for the chosen display plugin |
| `open` | boolean | `FALSE` | open the browser inline instead of a modal |
| `field_widget_edit` | boolean | `TRUE` | show the edit button |
| `field_widget_remove` | boolean | `TRUE` | show the remove button |
| `field_widget_replace` | boolean | `FALSE` | show the replace button |

## Read it back

```bash
drush cget core.entity_form_display.node.cfeb_eval.default content.field_cfeb_ref
# settings.fields.ref.type => entity_reference_entity_browser
```

The widget is hardcoded to cardinality 1 (`const CARDINALITY = 1`), so it always manages a
single referenced entity per Custom Field item. It has no effect on non-`entity_reference`
columns (the widget's `field_types` only lists `entity_reference`).
