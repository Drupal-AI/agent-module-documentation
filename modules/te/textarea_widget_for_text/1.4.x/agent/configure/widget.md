<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use a textarea widget on a short text field

The module has **no configure route** (`configure: null`) and no settings. It simply makes two
core widgets selectable for short text fields; you pick them per field on *Manage form display*.

## The one hook (whole module)

```php
function textarea_widget_for_text_field_widget_info_alter(array &$info) {
  $info['text_textarea']['field_types'][] = 'text';     // formatted single text field
  $info['string_textarea']['field_types'][] = 'string'; // plain text field
}
```

So after enabling the module:

- a **`string`** (plain text) field can use the **`string_textarea`** widget;
- a **`text`** (formatted, non-long) field can use the **`text_textarea`** widget.

## Selecting it (UI)

1. *Manage form display* for the bundle (e.g. `/admin/structure/types/manage/article/form-display`).
2. On the short text field's row, change the Widget from "Textfield" to **"Text area (multiple
   rows)"**.
3. **Update**, then **Save**.

## Where it is stored

Config entity `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`:

```yaml
content:
  field_subtitle:
    type: string_textarea      # or text_textarea for a formatted text field
    settings:
      rows: 5
      placeholder: ''
```

The widget settings (`rows`, `placeholder`) are core's standard textarea widget settings.

## Scripting

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_subtitle', ['type' => 'string_textarea', 'settings' => ['rows' => 5]])->save();
```

```bash
drush cget core.entity_form_display.node.article.default content.field_subtitle
# look for type: string_textarea (or text_textarea)
```

To revert, set the component `type` back to `string_textfield` / `text_textfield`.
