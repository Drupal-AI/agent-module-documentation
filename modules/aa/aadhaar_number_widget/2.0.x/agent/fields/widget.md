<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aadhaar Number Widget — field widget & Verhoeff validation

Single class: `Drupal\aadhaar_number_widget\Plugin\Field\FieldWidget\AadhaarNumberWidget`
(`src/Plugin/Field/FieldWidget/AadhaarNumberWidget.php`), extends `WidgetBase`.

## Plugin definition
```
@FieldWidget(
  id = "aadhaar_number_widget",
  module = "aadhaar_number_widget",
  label = "Aadhaar Number Widget",
  field_types = { "string" }
)
```
Attaches only to core `string` fields. No `defaultSettings()`, `settingsForm()`, or
`settingsSummary()` — the widget has no configuration.

## Install / enable
- `composer require drupal/aadhaar_number_widget` then `drush en aadhaar_number_widget -y`.
- Add (or reuse) a **Plain text (string)** field on a bundle. On **Manage form display**,
  set that field's widget to **Aadhaar Number Widget**. No settings to configure.
- There is no formatter; the value renders with whatever core string formatter you choose.

## Form element — `formElement()`
Builds `$element['value']` as a `#type => 'textfield'`, `#default_value` from
`$items[$delta]->value`, `#maxlength => 14` (fits the dashed/spaced 14-char forms), and
`#element_validate => [[static::class, 'validate']]`. No input filtering or transformation is
applied; the raw entered string is what gets stored by the string field.

## Validation — `validate()` (static)
1. Empty value (`'' `/`NULL`) → returns, no error (field required-ness is enforced by core).
2. Regex `"/(^\d{12}$)|(^\d{4}\s\d{4}\s\d{4}$)|(^\d{4}-\d{4}-\d{4}$)/"` — accepts exactly one of:
   `968415522551`, `9684 1552 2551`, `9684-1552-2551`. No match → format error
   (`t('Invalid Aadhaar number format...')`, static text with literal `<br>` markup).
3. Match → `isAadhaarValid()`; false → `t('The Aadhaar number is not valid.')`.

Both errors use `$form_state->setError($element, ...)`, which halts the entity save.

## Checksum — `isAadhaarValid()` / `calculateChecksumDigit()`
- `isAadhaarValid(string $num)`: `preg_replace('/[-\s]/', '', $num)` strips separators, takes the
  last char as the expected check digit, recomputes over `substr($num, 0, -1)`, compares as
  strings.
- `calculateChecksumDigit(string $partial)` implements the **Verhoeff** algorithm (UIDAI's
  scheme): hard-coded `$dihedral` (D5 multiplication), `$permutation`, and `$inverse` tables;
  reverses the partial, folds each digit through `permutation[(i+1)%8]` then the dihedral table,
  and returns `inverse[c]`. Matches UIDAI test vectors used in
  `tests/src/Functional/AadhaarNumberWidgetTest.php` (e.g. `999941057058` valid,
  `999941057057` invalid).

## What it does NOT do
No masking, encryption, hashing, access control, logging, or external UIDAI verification —
validation only. For real Aadhaar/PII handling combine with Field Encryption, Field
Permissions, and a masking display; the stored value is plaintext in the field's DB column.

## Hook
`aadhaar_number_widget_help()` in `aadhaar_number_widget.module` returns a one-line About
blurb on `help.page.aadhaar_number_widget`. That is the only procedural code.
