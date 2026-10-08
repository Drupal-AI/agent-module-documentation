<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select a "Hidden field" widget

The module has **no configure route** (`configure: null`) and no settings form. You enable it
per field by choosing one of its widgets on the entity bundle's **Manage form display** page.
The choice is stored as the component `type` in the `entity_form_display` config entity.

## Which widget id for which field type

| Field type | Widget id | Extends |
|---|---|---|
| `string` (Text, plain) | `field_hidden_string_textfield` | core `StringTextfieldWidget` |
| `string_long` (Text, plain, long) | `field_hidden_string_textarea` | core `StringTextareaWidget` |
| `integer`, `decimal`, `float` | `field_hidden_number` | core `NumberWidget` |

All three show the label **"Hidden field"** in the widget select. There is no widget for
formatted (rich) text — core text-processing can't be rendered as a hidden input.

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`, e.g.
`core.entity_form_display.node.article.default`. The field's component looks like:

```yaml
content:
  field_secret_code:
    type: field_hidden_string_textfield   # or field_hidden_string_textarea / field_hidden_number
    weight: 5
    region: content
    settings: {  }
    third_party_settings: {  }
```

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. Article:
   `/admin/structure/types/manage/article/form-display`).
2. In the field's **Widget** column select **Hidden field**.
3. **Save**. The value is now rendered as `<input type="hidden">` on that entity's forms.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_secret_code', [
  'type' => 'field_hidden_string_textfield',   // match the field type (see table)
  'weight' => 5, 'region' => 'content',
])->save();
```

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_secret_code
# look for  type: field_hidden_string_textfield
```

## "Hidden field" vs "- Hidden -"

Choosing **"- Hidden -"** in Manage form display *removes* the field from the form — no input
is rendered and no value is submitted, so a default value is not written on that form.
**"Hidden field"** (this module) keeps the field in the form as a hidden input, so a default or
JS/programmatically set value is submitted and saved normally. Use this module when you need
the value to round-trip; use "- Hidden -" when you want the field off the form entirely.
