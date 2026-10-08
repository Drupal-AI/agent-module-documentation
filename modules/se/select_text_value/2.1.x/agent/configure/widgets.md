<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Select Text Value widgets

The module has **no configure route and no settings form** (`configure: null`). You use it
by choosing one of its widgets on a text field's *Manage form display* page and setting the
widget options. Everything is stored in the field's `entity_form_display` config.

## Which widget for which field type

| Widget id (`type`) | Applies to field type | Extends core widget |
|---|---|---|
| `select_string_textfield` | `string` (Text, plain) | `StringTextfieldWidget` |
| `select_string_textarea`  | `string_long` (Text, plain, long) | `StringTextareaWidget` |
| `select_text_textfield`   | `text` (Text, formatted) | `TextfieldWidget` |
| `select_text_textarea`    | `text_long` (Text, formatted, long) | `TextareaWidget` |

All four carry the human label **"Select text value"** in the *Manage form display* widget
dropdown. They only appear for their matching field type.

## Settings keys

Stored under `content.<field>.settings` in the form-display config. Defaults come from
`WidgetHelper::defaultSettings()`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `select_type` | string | `select` | `select` (dropdown), `radios` (radio buttons), or `checkboxes`. **`checkboxes` is only offered when the field cardinality ≠ 1** (multi-value). |
| `allowed_values` | string (textarea) | `''` (required) | The options. **One value per line.** A plain line is used as both the stored value and the label. A `key|label` line is parsed into key⇒label. |
| `custom_value_label` | label | `Other` | Text of the extra option that, when picked, reveals the original text input for a free-form value. **Leave empty to restrict editors to the allowed list only** (no free entry). |
| `custom_value_field_title` | label | `''` | Title shown on the free-text input when "Other" is selected. |
| `custom_value_field_description` | text | `''` | Help text for that free-text input (filtered HTML). |

Note: despite the allowed-values help text mentioning `key|label`, the README recommends
plain one-value-per-line entries, because the value is stored verbatim as the field's normal
text value — there is no separate key/label storage like `list_string`.

## How it behaves at edit time

- The widget renders a `container` with a `select` element (of `#type` = `select_type`) plus
  the original `field` input.
- When `custom_value_label` is set, a `_custom_value` option is appended. Selecting it uses
  Drupal `#states` to make the original text input `visible` and `required`; otherwise that
  input is hidden.
- On load, a stored value that matches an allowed value pre-selects it; a non-matching stored
  value selects "Other" and pre-fills the text input.
- On save, `massageFormValues()` writes back the chosen option (or the custom text) in the
  field's **normal** storage shape (`value`, plus `format` for formatted text). No key mapping.
- For `checkboxes`, `handlesMultipleValues()` returns TRUE: one checkboxes element captures all
  deltas, and each checked value (or the custom text) is expanded into its own storage delta.

## Where the config lives

```
core.entity_form_display.<entity_type>.<bundle>.<form_mode>
  content:
    <field_name>:
      type: select_string_textfield        # one of the four ids
      settings:
        select_type: radios
        allowed_values: "Low\nMedium\nHigh"
        custom_value_label: Other
        custom_value_field_title: ''
        custom_value_field_description: ''
```

Read it back:

```bash
drush cget core.entity_form_display.node.article.default content.field_my_text
```

## Scriptable set-up (drush php:eval)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setComponent('field_my_text', [
  'type' => 'select_string_textfield',
  'weight' => 10,
  'region' => 'content',
  'settings' => [
    'select_type' => 'select',
    'allowed_values' => "Low\nMedium\nHigh",
    'custom_value_label' => 'Other',
    'custom_value_field_title' => '',
    'custom_value_field_description' => '',
  ],
])->save();
```

To lock editors to the list (no free-text "Other"), set `custom_value_label` to `''`.
To offer checkboxes, the field storage cardinality must be > 1 (or unlimited, `-1`), then set
`select_type` to `checkboxes`.
