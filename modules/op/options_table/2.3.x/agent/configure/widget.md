<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Draggable Table (`options_table`) widget

The module adds no admin page. You choose the widget per field, per form mode, on the entity's
**Manage form display**, or directly in the `entity_form_display` config entity.

## Which fields it applies to

The widget (`OptionsTableWidget`, id `options_table`) declares these field types:

- `list_string`, `list_integer`, `list_float` (core Options / List fields)
- `entity_reference`

It extends `OptionsWidgetBase` and is `multiple_values: TRUE`, so one widget renders all deltas
as one table. On a **multi-value** field it shows checkboxes; on a **single-value** field it
shows radios (and reordering is moot). It requires the core **Options** module (`options`).

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`

```yaml
content:
  <field_name>:
    type: options_table
    settings:
      toggle_label: 'Show?'   # optional; heading of the checkbox/radio column
    weight: 5
    region: content
    third_party_settings: {  }
```

The only widget-specific setting is `toggle_label` — an optional string used as the header of
the second (checkbox/radio) column. If empty, the settings summary reads "No toggle label".

## Via the UI

1. Go to the bundle's *Manage form display*
   (e.g. Article: `/admin/structure/types/manage/article/form-display`).
2. In the **Widget** column of an options/entity-reference field, choose **Draggable Table**.
3. (Optional) Click the gear/cog, set **Toggle label**, then **Update**.
4. **Save**. Editors now see a table with a drag handle and a **Weight** column; they tick rows
   and drag to order them. For multi-value fields the drag order becomes the stored delta order.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$component = $fd->getComponent('field_choices');           // an options/entity_reference field
$component['type'] = 'options_table';
$component['settings'] = ['toggle_label' => 'Show?'];      // toggle_label is optional
$fd->setComponent('field_choices', $component)->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_choices
# expect: type: options_table  (and settings.toggle_label if set)
```

## Config schema

The module ships `field.widget.settings.options_table` with a single `toggle_label` string, so
the setting validates as part of the form-display config. There is no other configuration.
