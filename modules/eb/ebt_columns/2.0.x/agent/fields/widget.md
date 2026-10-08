<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: `ebt_settings_columns`

`src/Plugin/Field/FieldWidget/EbtSettingsColumnsWidget.php`

```php
@FieldWidget(
  id = "ebt_settings_columns",
  label = @Translation("EBT Columns / Container settings"),
  field_types = { "ebt_settings" }
)
class EbtSettingsColumnsWidget extends EbtSettingsDefaultWidget { … }
```

Extends ebt_core's **`EbtSettingsDefaultWidget`**, so it inherits the whole shared EBT design form
(CSS box, background, edge-to-edge, container width, etc.). It targets the `ebt_settings` field
type and is assigned to `field_ebt_settings` in this bundle's form display. It adds only the
column-specific controls; all values are merged into the same `ebt_settings` sub-array.

## Added form elements (`formElement()`)

`parent::formElement(...)` builds the base element first, then this widget appends into
`$element['ebt_settings']`:

| Key | Type | Options | Default | Weight |
|---|---|---|---|---|
| `layout` | radios | `1` One column (Container), `2` Two, `3` Three, `4` Four, `5` Five, `6` Six columns | `1` | 5 |
| `column_width_two` | select | `50-50`, `33-67`, `67-33`, `25-75`, `75-25` | `50-50` | 8 |
| `column_width_three` | select | `25-50-25`, `33-34-33`, `25-25-50`, `50-25-25` | `33-34-33` | 8 |
| `column_width_four` | select | `25-25-25-25`, `40-20-20-20`, `20-20-20-40` | `25-25-25-25` | 8 |

Defaults read from `$items[$delta]->ebt_settings['<key>'] ?? <default>`. Each `column_width_*`
select is shown only for the matching layout via `#states` `visible` keyed on
`:input[name$="[ebt_settings][layout]"]` `value` = 2 / 3 / 4. Layouts 5 and 6 expose no width
select (equal columns only). The choices are the exact strings the CSS maps to grid templates — see
[../theming/templates.md](../theming/templates.md).

## `massageFormValues()`

```php
foreach ($values as &$value) {
  $value += ['ebt_settings' => []];
}
return $values;
```

Just guarantees each delta has an `ebt_settings` key before save; it does not transform or filter
the individual settings (the base widget handles the shared design values).

## Notes

- The layout/width values are constrained to the listed radio/select options in the UI, and every
  value is emitted only as a CSS class via `attributes.addClass()` (Drupal escapes attribute
  values on render) — they are never printed as raw markup by this module.
- The widget contributes no config of its own; the values live inside the block_content entity's
  `field_ebt_settings` value. No config schema is shipped here for these extra keys.
