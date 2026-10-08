<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure validation rules

No admin settings page (`configure` is `null`). You configure per element: open a webform's
*Build* tab, edit an element, and use the **"Form extra validation"** fieldset. Each choice is
saved as a `#`-prefixed property on that element in the webform's `elements` YAML.

## 1. Equal values (`equal`)

All selected components must hold equal values (emails compared case-insensitively).

| Property | Meaning |
|---|---|
| `#equal__enabled` | `1` to turn the rule on |
| `#equal__components` | map of element keys to validate as equal, e.g. `{ email_a: email_a }` |

```yaml
confirm_email:
  '#type': email
  '#title': 'Confirm email'
  '#equal__enabled': 1
  '#equal__components':
    email: email
```

## 2. Compare two values (`compare`)

Compares this element against another with an operator. Element type must be in
`ALLOWED_TYPES_COMPARE` (date, datetime, number, webform_time).

| Property | Meaning |
|---|---|
| `#compare__enabled` | `1` to turn on |
| `#compare__component` | the other element key to compare against |
| `#compare__operator` | one of `>`, `>=`, `<`, `<=` |
| `#compare__custom_error` | optional custom error message |

Semantics (from `validateFrontCompareComponent`): with operator `>`, validation passes when
`min(compareWith) > max(thisValue)` — i.e. the *compared-with* element must be greater.

```yaml
end_date:
  '#type': date
  '#title': 'End date'
  '#compare__enabled': 1
  '#compare__component': start_date
  '#compare__operator': '>'
  '#compare__custom_error': 'End date must be after start date.'
```

## 3. Some of several (`some_of_several`)

Require a number of a group of components to be completed.

| Property | Meaning |
|---|---|
| `#some_of_several__enabled` | `1` to turn on |
| `#some_of_several__components` | map of element keys in the group |
| `#some_of_several__completed` | requirement string: `>=1`, `=3`, `<=2` (operator + number) |
| `#some_of_several__final_validation` | `1` to validate only on the final wizard page |

```yaml
phone:
  '#type': tel
  '#title': 'Phone'
  '#some_of_several__enabled': 1
  '#some_of_several__completed': '>=1'
  '#some_of_several__components':
    phone: phone
    email: email
```

## Supported element types

The "Form extra validation" fieldset only appears on elements whose type is in
`WebformValidateConstraint::ALLOWED_TYPES`: date, datetime, email, hidden, number, select,
tel, textarea, textfield, webform_document_file, webform_entity_checkboxes, webform_signature,
webform_time. The **compare** validator additionally requires the type to be in
`ALLOWED_TYPES_COMPARE` (date, datetime, number, webform_time).

## Config-form validation gotchas

`WebformValidateConstraint::validateBackendComponents` runs when you save the element: it
requires ≥1 component when `equal`/`some_of_several` are enabled, requires a component and an
operator when `compare` is enabled, and normalises `some_of_several__completed`. When compare
is disabled it strips the stored `compare__component`/`compare__operator`.
