# Field widget: `map_assoc_widget`

Edits a core **`map`** field as a repeatable table of key/value textfield pairs. Class
`Drupal\map_widget\Plugin\Field\FieldWidget\AssociativeArrayWidget` (extends `WidgetBase`),
declared with `#[FieldWidget(id: 'map_assoc_widget', field_types: ['map'], multiple_values: TRUE)]`.
It is the only widget for the `map` field type; core ships none.

## Attaching it

The core `map` field is **not available in Field UI** — it is added as a base field in code.
Point its form display at this widget:

```php
// In hook_entity_base_field_info() / an entity's baseFieldDefinitions().
$fields['query_params'] = BaseFieldDefinition::create('map')
  ->setLabel(t('Query parameters'))
  ->setDisplayOptions('form', [
    'type' => 'map_assoc_widget',
    'region' => 'content',
    'weight' => 90,
    'settings' => [
      'size' => 40,
      'key_placeholder' => 'The identifier',
      'value_placeholder' => 'Pre-filled value',
    ],
  ])
  ->setDisplayConfigurable('form', TRUE)
  ->setDisplayConfigurable('view', FALSE);
```

Where the base field is `setDisplayConfigurable('form', TRUE)`, the widget can also be chosen and
its settings edited on the entity's *Manage form display* page (it is the only option for `map`).

## Widget settings

Defined in `defaultSettings()` / `settingsForm()`; schema in
`config/schema/map_widget.schema.yml` under `field.widget.settings.map_assoc_widget`.

| Setting | Type (schema) | Default | Form field | Effect |
|---|---|---|---|---|
| `size` | integer | 60 | number, required, min 1 | `#size` (char width) of every key and value textfield |
| `key_placeholder` | label | `''` | textfield | `#placeholder` on the key inputs |
| `value_placeholder` | label | `''` | textfield | `#placeholder` on the value inputs |

`settingsSummary()` echoes the size and any non-empty placeholders on the Manage-form-display row.

Set the settings from code on a form display:

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('entity_test', 'entity_test');
$display->setComponent('query_params', [
  'type' => 'map_assoc_widget',
  'settings' => ['size' => 40, 'key_placeholder' => 'Key', 'value_placeholder' => 'Value'],
])->save();
```

## Runtime behavior (`formElement()`)

- Renders one `#type => 'map_associative'` element (see `../api/element.md`) seeded with
  `$items[$delta]->value` as `#default_value` and the three settings.
- **Add-more:** unless the form is programmed, it appends an *"Add an entry"* submit button with
  an AJAX callback. `addMorePairsSubmit()` increments a per-delta counter kept in widget state
  (`$field_state['map_assoc_count'][$delta]`) and rebuilds; `addMorePairsAjax()` returns the
  refreshed element. `initCount()` seeds that counter from the number of existing pairs (min 1).
  So the visible number of empty rows = stored pairs, plus one per click.
- **Save:** `massageFormValues()` strips the injected `add_more` key; the real value comes from
  the element's `#value`. The stored field value is a plain PHP associative array
  (`['key' => 'value', ...]`) — pairs whose value is `NULL` or `''` are dropped by the element's
  value callback, and on a duplicate key the last pair wins.

## Notes for integrators

- Keys are whatever the editor types; there is no per-key schema (the point of `map`, but it means
  config-schema validation cannot check the stored contents). Normalise/validate downstream if you
  expect specific keys.
- The field has no formatter here — `setDisplayOptions('view', ...)` is typically `region: hidden`;
  read the value in code via `$entity->get('field')->value` (the array) or `->getValue()`.
- `map_widget_update_8101()` (in `map_widget.install`) is a one-off DB update that repairs
  map values corrupted by an older release; it runs from `update.php`/`drush updb`, not at install.
