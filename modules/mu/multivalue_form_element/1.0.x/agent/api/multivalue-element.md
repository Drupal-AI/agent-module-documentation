<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `multivalue` form element

Class: `Drupal\multivalue_form_element\Element\MultiValue` (`#[FormElement('multivalue')]`,
extends `FormElementBase`). Use it inside a form's `buildForm()` array. It has no services,
no config, and no admin UI — this is the entire public surface.

## Declaring the element

Put child elements **directly inside** the `multivalue` element. Each delta (row) repeats all
children. Give the wrapper a `#title`; children get their own `#type`/`#title`.

Single child (a repeatable text field):
```php
$form['job_titles'] = [
  '#type' => 'multivalue',
  '#title' => $this->t('Job titles'),
  'title' => [
    '#type' => 'textfield',
    '#title' => $this->t('Job title'),
    '#title_display' => 'invisible',
  ],
];
```

Multiple children per row (a name + e-mail pair, capped at 3 rows):
```php
$form['contacts'] = [
  '#type' => 'multivalue',
  '#title' => $this->t('Contacts'),
  '#cardinality' => 3,
  'name' => ['#type' => 'textfield', '#title' => $this->t('Name')],
  'mail' => ['#type' => 'email', '#title' => $this->t('E-mail')],
];
```

## Element properties (from `getInfo()`)

| Property | Default | Meaning |
|---|---|---|
| `#cardinality` | `MultiValue::CARDINALITY_UNLIMITED` (`-1`) | Max rows. A positive int caps rows; `-1` = unlimited and renders the AJAX add-more button. |
| `#add_more_label` | `t('Add another item')` | Label of the "add more" submit button. Only shown for unlimited cardinality. |
| `#input` | `TRUE` | It is an input element. |
| `#theme` | `field_multiple_value_form` | Rendered with core's field multi-value table theme (draggable weight per row). |
| `#cardinality_multiple` | `TRUE` | Tells the theme it is a multiple-value table. |
| `#description` | `NULL` | Optional wrapper description. |

Constant: `MultiValue::CARDINALITY_UNLIMITED = -1`.

Fixed callbacks (do not override): `#process` = `processMultiValue` + `processAjaxForm`;
`#element_validate` = `validateMultiValue`; value callback = `valueCallback`.

## Default values

Set `#default_value` **on the wrapper**, keyed by numeric delta — never on the children
(child defaults are overwritten). Full form:
```php
'#default_value' => [
  0 => ['name' => 'Bob', 'mail' => 'bob@example.com'],
  1 => ['name' => 'Ted', 'mail' => 'ted@example.com'],
],
```
Single-child shorthand — you may omit the child name and pass scalars:
```php
'title' => ['#type' => 'textfield'],
'#default_value' => ['Foo', 'Bar'],   // becomes [0 => ['title' => 'Foo'], 1 => ['title' => 'Bar']]
```
Deltas must be numeric; non-numeric keys are ignored (`valueCallback`). The initial number of
rows shown equals `count(#default_value)` (unlimited cardinality), or `#cardinality` when capped.

## Required behaviour

`#required` on the wrapper applies **only to the first delta** (like an entity field):
- If no child declares `#required`, all children of delta 0 are forced required.
- If some child declares `#required`, that per-child setting is kept for delta 0.
- All deltas after the first (and every delta when the wrapper is not required) have their
  children forced to `#required => FALSE`.

To keep a child required on *every* row, drive it with `#states` instead of `#required`.

## Submitted value shape

After `validateMultiValue` runs, `$form_state->getValue('contacts')` is a **clean,
consecutively-keyed** array of rows, each row keyed by child name:
```php
[
  0 => ['name' => 'Bob', 'mail' => 'bob@example.com'],
  1 => ['name' => 'Ted', 'mail' => 'ted@example.com'],
]
```
Processing applied on submit:
- The `add_more` button value is removed.
- Rows are sorted by their hidden per-row `_weight` (drag order), then `_weight` is stripped.
- A row where **all** children are empty (`'' `/`NULL`/empty array) is dropped.
- Remaining rows are re-keyed `0..n`.

Values always carry the full `child_name => value` structure, even when you used the
single-child scalar shorthand for defaults.

## Notes

- Works nested inside containers; the add-more button `#name` and AJAX wrapper id are derived
  from the element's `#parents`, so multiple/nested `multivalue` elements coexist safely.
- `@todo` in source: nested child elements in `setDefaultValue` are not fully handled — keep
  children flat (one level).
- No `hook_*`, service, or config to wire up: enable the module and the `multivalue` element
  type is available to any form.
