# Forms API `#type` render elements

Two reusable elements you can drop into any form array. Each expands into a `select` subfield
plus an `other` textfield that is shown (Form API `#states`) only when the `- Other -` choice
is picked. No contrib dependency.

| `#type` | Renders | Class |
|---|---|---|
| `select_or_other_select` | a `<select>` | `Drupal\select_or_other\Element\Select` |
| `select_or_other_buttons` | `radios` (single) or `checkboxes` (multiple) | `Drupal\select_or_other\Element\Buttons` |

## Example

```php
$form['options'] = [
  '#type' => 'select_or_other_select',
  '#title' => $this->t('Options'),
  '#options' => [
    'value_1' => $this->t('One'),
    'value_2' => $this->t('Two'),
  ],
  '#multiple' => TRUE,
];
```

## Properties (from `ElementBase::getInfo()` + docblock)

| Property | Default | Meaning |
|---|---|---|
| `#options` | `[]` | Associative array of `value => label` choices |
| `#multiple` | `FALSE` | Allow selecting multiple values |
| `#select_type` | `'list'` | `'list'` (select) or `'buttons'` (radios/checkboxes) |
| `#input_type` | `'textfield'` | Element type used for the "Other" field |
| `#merged_values` | `FALSE` | If `TRUE`, return one flat array merging the `select` and `other` values |
| `#other_option` | — | Label for the "Other" choice (empty → `- Other -`) |
| `#other_field_label` | — | Label for the "Other" textfield |
| `#other_placeholder` | — | Placeholder for the "Other" textfield |
| `#other_allowed` | `TRUE` | Whether the "Other" choice/textfield is offered at all |
| `#no_empty_option` | — | Suppress the empty/"none" option on the select |
| `#empty_option` / `#empty_value` | — | Label / value denoting no selection |

Also honored: `#required`, `#default_value`, `#title`, and `#ajax` (forwarded to the inner
`select`). The element sets `#tree => TRUE`.

## Return value (`valueCallback`)

- **Single value:** picking a normal option returns `[selected_value]`; picking `- Other -`
  returns `[<text typed in other>]` (and that text is added to `#options` so it validates).
- **Multiple, `#merged_values` on:** returns a flat array of the checked options plus any
  "other" text.
- **Multiple, `#merged_values` off:** returns `['select' => [...], 'other' => [...]]`; the
  `other` array is only kept when `- Other -` is among the selected options.

Multi-value selects can't use core `#states`, so the select variant attaches the
`select_or_other/multiple_select_states_hack` JS library to toggle the "Other" field.

Note: the module overrides core's `AllowedValues` validation constraint (via
`hook_validation_constraint_alter()`) so freely-typed "other" values pass validation.
