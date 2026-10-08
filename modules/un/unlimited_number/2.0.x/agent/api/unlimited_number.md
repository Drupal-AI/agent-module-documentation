<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `#type => unlimited_number` render element

Class: `Drupal\unlimited_number\Element\UnlimitedNumber` (a Form API `FormElement`, plugin id
`unlimited_number`). Enable the module (`drush en unlimited_number -y`), then use it in any
custom form's `buildForm()`, a render array, or `hook_form_alter()`.

It renders **two radios** — "Unlimited" and "Limited" — and an inline `#type => number` field
that belongs to the "Limited" branch. The element resolves to a single scalar value.

## Properties

| Property | Meaning |
|---|---|
| `#default_value` | An integer, **or** the string `UnlimitedNumber::UNLIMITED` (`'unlimited'`). A numeric value pre-selects "Limited" and fills the number; `'unlimited'` pre-selects "Unlimited". |
| `#min` / `#max` / `#step` | Passed to the inner `#type => number` element (`#step` uses `#min` as the base). |
| `#field_prefix` / `#field_suffix` | Passed to the inner number element (e.g. `$`, `items`). |
| `#options['unlimited']` | Label for the unlimited radio (defaults to `t('Unlimited')`). |
| `#options['limited']` | Label for the limited radio (defaults to `t('Limited')`). |
| `#title` / `#description` / `#required` | Standard; applied to the radios group. |
| `#ajax` | Propagated to the radios and the number sub-element. |

## Return / submitted value

On submit the element sets **one** value via `setValueForElement`:

- `UnlimitedNumber::UNLIMITED` (the string `'unlimited'`) when the Unlimited radio is chosen.
- the entered **integer** when the Limited radio is chosen.
- `NULL` when nothing is selected.

Read it from `$form_state->getValue('your_key')` — it is a flat scalar, not a nested array.

```php
use Drupal\unlimited_number\Element\UnlimitedNumber;

$form['cardinality'] = [
  '#type' => 'unlimited_number',
  '#title' => $this->t('Number of values'),
  '#default_value' => UnlimitedNumber::UNLIMITED,   // or an integer like 5
  '#min' => 1,
  '#options' => [
    'unlimited' => $this->t('Unlimited'),
    'limited' => $this->t('Limited, up to a number'),
  ],
];

// In submitForm():
$value = $form_state->getValue('cardinality');
if ($value === UnlimitedNumber::UNLIMITED) {
  // treat as unlimited (map to your own sentinel, e.g. -1 or 0)
}
else {
  // $value is the entered integer
}
```

## Validation

The element's `#element_validate` enforces that when **Limited** is chosen a number is
actually entered — otherwise it sets a form error:
`"A number must be entered. Otherwise choose @unlimited."` The empty-number case does not
require the whole element; only the number sub-field errors.

## Gotchas

- **Does not render in isolation.** The element builds its radios/number in a `#process`
  callback that needs `$form_state` and the complete form, so
  `\Drupal::service('renderer')->renderInIsolation($build)` on a bare `#type =>
  unlimited_number` returns an empty string. Exercise it through a real form build
  (`\Drupal::formBuilder()->getForm(...)` or an entity form) instead.
- The element sets `#tree = TRUE` on itself internally; its own returned value is still a flat
  scalar (the tree is an implementation detail of the child radios/number).
- "Unlimited" is a **string** at this layer. If you need an integer sentinel in storage, map it
  yourself — or use the field widget, which does that mapping for you (see
  [../plugins/unlimited_number.md](../plugins/unlimited_number.md)).
