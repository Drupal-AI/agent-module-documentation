<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three "Hidden field" widget plugins

Field Hidden defines three `@FieldWidget` plugins in
`src/Plugin/Field/FieldWidget/`. Each subclasses the matching core widget, calls the parent
to build the row, then converts the value column to a hidden input. There is no plugin *type*
defined by this module — these are ordinary core Field API widget plugins.

## Plugins

| Plugin id | Class | field_types | Parent widget |
|---|---|---|---|
| `field_hidden_string_textfield` | `FieldHiddenStringTextfieldWidget` | `string` | `StringTextfieldWidget` |
| `field_hidden_string_textarea` | `FieldHiddenStringTextareaWidget` | `string_long` | `StringTextareaWidget` |
| `field_hidden_number` | `FieldHiddenNumberWidget` | `integer`, `decimal`, `float` | `NumberWidget` |

All three use `label = @Translation("Hidden field")`.

## What each `formElement()` does

```php
$row = parent::formElement(...);              // normal core element ("row")
if ($form_state->getFormObject()->getFormId() != 'field_ui_field_edit_form') {
  $row['value']['#type'] = 'hidden';          // make the value a hidden input
  $row['value']['#attributes']['class'][] = 'field-hidden-<type>';
  $row['value']['#attached']['library'][] = 'field_hidden/drupal.field_hidden';
}
return $row;
```

Key behaviors:

- The conversion is **skipped on `field_ui_field_edit_form`**, so on the field's own settings
  page the input stays visible — you can still type a default value there.
- A CSS class is added for targeting/JS:
  - Text: `field-hidden-string`
  - Text long: `field-hidden-string-long`
  - Integer: `field-hidden-integer`
  - Decimal: `field-hidden-decimal`
  - Float: `field-hidden-float`
  (Number widget uses the field type directly; the string widgets replace `_` with `-`.)
- The `field_hidden/drupal.field_hidden` library is attached to hide extra rows on multi-value
  fields (only the hidden inputs remain, no visible add-more clutter).

## Not the same as "- Hidden -"

Core's "- Hidden -" option removes the component from the form entirely (no submitted value).
These widgets keep the field present as a hidden input, so its value is submitted and saved.

## Implementing your own

There is nothing to extend here beyond core: if you need a hidden widget for another field
type, subclass that type's core widget and repeat the `#type => 'hidden'` pattern above. This
module deliberately covers only number and plain-text (`string` / `string_long`) types.
