<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form elements, validation and donor search

The base module ships four reusable render elements plus a validation helper that any form can
opt into.

## Render elements (`src/Element/*`, base `src/FormElementBase.php`)

- `donorperfect_name` (`Element\Name`) — a compound name field. When the current user has the
  `donorperfect user` permission it renders an AJAX "search DonorPerfect" control that POSTs to
  `donorperfect.form_element.name.search` and shows possible matches; picking a match can fill the
  address/email/phone elements. Attaches libraries `donorperfect/form_element.name` and
  `.name.search`.
- `donorperfect_address` (`Element\Address`), `donorperfect_email` (`Element\Email`),
  `donorperfect_phone` (`Element\Phone`) — value elements with DonorPerfect-style validation and
  max-lengths (`DPUtility` constants: first name 50, last name 75, address 100, city 50, zip 20,
  email 75, phone 40).

CSS/JS are declared in `donorperfect.libraries.yml` (`toolbar`, `form_element`,
`form_element.name`, `form_element.name.search`).

## Validation / filtering (`src/FormValidator.php`)

`donorperfect_form_alter()` (in `donorperfect.module`) calls `FormValidator::addValidation($form)`
on **every** form; it recurses the element tree and attaches
`FormValidator::validateElement` to any element carrying a `#dp_validate` or `#dp_filter` key. So
any custom form can request DonorPerfect validation/formatting by setting, e.g.:

```php
$form['amount'] = [
  '#type' => 'textfield',
  '#dp_validate' => 'money',   // or ['email'], ['phone'], ['alphaDash'], ['decimal'], ['digit']
  '#dp_filter'   => 'money',   // matching filter reformats the submitted value
];
```

`validateElement()` runs each `validate<Type>()`; on success it runs the matching `filter<Type>()`
and writes the reformatted value back to `$form_state`; on failure it sets a form error.

Available validators (return `TRUE` or an error message): `validateEmail` (core email.validator),
`validateUrl`, `validatePhone` (10 digits), `validateAlphaDash`
(`[ 0-9a-zA-Z,'#@!_\-\./?()]`), `validateDecimal`, `validateMoney`, `validateDigit`. Filters:
`filterEmail`, `filterPhone` (`(555) 555-5555` or dashes), `filterAlphaDash`, `filterDecimal`,
`filterMoney`, `filterDigit`, `filterCheckPlain` (`Html::escape`), `filterXss` (`Xss::filter`),
`filterProperCase`, `filterLowerCase`/`filterUpperCase`/`filterTrim`,
`filterUnsupportedCharacters` (`&`→` and `, `# `→`Unit `).

## Donor search endpoint (`DonorPerfectController::searchDonors`)

`POST /donorperfect/form_element/name/search` (perm `donorperfect user`). Reads
`element_token`, `donor_type`, `last_name`, `first_name` from the request. If `donorperfect_donor`
is enabled it builds search conditions (last name with a trailing wildcard; when donor_type = `IN`
it also matches first name) and calls `donorperfect_donor.entity_controller::search()`, then loads
the matching donor entities. It returns an `AjaxResponse` that renders a matches table
(name/address/city/state/zip/email) into the element wrapper; each row carries a "Match" link whose
`result-data` attribute holds the donor fields as JSON for the client to auto-fill.

Rendered donor values are placed into a `#theme => 'table'` render array (`data` keys), so
DonorPerfect-returned text is escaped by the table theme. Search input reaching
`DonorController::search()` is validated/escaped there (alpha-dash / email / phone checks and
single-quote doubling) before any DonorPerfect condition is built — see the
[donor submodule](../../modules/donorperfect_donor/1.0.x/agent/entity/donor.md).
