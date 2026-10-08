<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Belgian National Insurance Number (webform_rrn_nrn) — agent index

Adds one **Webform element** for the Belgian national number (rijksregisternummer / numero de
registre national, RRN/NRN): a masked text field that validates the modulo-97 checksum. Info-file
name is *"Belgian National Insurance Number"*, package **`Custom`**. Depends only on
**`webform`** (`webform:webform`). Core requirement `^9.3 || ^10 || ^11`. License GPL-2.0-or-later.
Version 8.x-2.4 (version dir `8.x-2.x`).

- **The element, its validation, the input mask, and how to add it to a form** →
  [elements/belgian_national_insurance_number.md](elements/belgian_national_insurance_number.md)

## What it actually is

Two classes, no config objects, no permissions, no routes, no services, no Drush, no submodules:

- **Form element** `WebformBelgianNationalInsuranceNumber` (id
  **`webform_belgian_national_insurance_number`**), `src/Element/WebformBelgianNationalInsuranceNumber.php`,
  extends core `FormElement`. A `#type => 'textfield'`, `#size => 15`, with `#process`,
  `#element_validate` and `#pre_render` callbacks. `#pre_render` sets `data-inputmask-mask =
  999999-999-99` and attaches library **`webform/webform.element.inputmask`**.
- **Webform element plugin** `WebformBelgianNationalInsuranceNumber` (same id),
  `src/Plugin/WebformElement/WebformBelgianNationalInsuranceNumber.php`, extends
  `WebformElementBase`. Annotation `category = "Basic elements"`, `states_wrapper = TRUE`. Its
  `form()` adds one required **Error message** textfield to the element edit UI; display/formatting
  and storage are all inherited defaults from `WebformElementBase`.

## Mechanism (from source)

- `validateBelgianNationalInsuranceNumber()` (the element's `#element_validate`) reads the value by
  `#webform_key`, returns early if empty and not required, then computes the modulo-97 check:
  `$rrn_calc_value = (int)(substr($rrn_nrn,0,6) . substr($rrn_nrn,7,3))`, `$check_digit =
  (int)substr($rrn_nrn,11,2)`. It passes if `(97 - ($rrn_calc_value % 97)) == $check_digit` (pre-2000)
  **or** `(97 - (($rrn_calc_value + 2000000000) % 97)) == $check_digit` and the two-digit year prefix
  is `<=` the current year (post-2000). Otherwise `$form_state->setError($element,
  $element['#error_message'])`.
- The number is stored and displayed as a plain textfield value through `WebformElementBase`
  defaults — the module adds no custom formatter.

## Hooks

`webform_rrn_nrn.module` implements only `hook_locale_translation_projects_alter()` (points the
interface-translation server at the shipped `translations/%language.po`, i.e. `fr.po`, `nl.po`) and
an empty `hook_help()` returning `NULL`.
