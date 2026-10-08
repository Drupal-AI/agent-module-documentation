<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Belgian National Insurance Number webform element

## Install & enable

```bash
composer require drupal/webform_rrn_nrn
drush en webform_rrn_nrn -y
```

Only dependency is contrib **`webform`** (`webform:webform`). No sub-modules, no permissions of its
own, no Drush commands, no config objects or schema.

## Add it to a webform

The element (plugin id **`webform_belgian_national_insurance_number`**, label *"Belgian National
Insurance Number"*) appears in the Webform element picker under the **Basic elements** category
(annotation `category = @Translation("Basic elements")` — note the README's older text says
*Custom*).

UI path: *Structure → Webforms → (your webform) → Build → + Add element →* pick **Belgian National
Insurance Number**. In the element settings, the **Error message** field (in the *Belgian National
Insurance Number* details group) is **required** — it is the message shown on an invalid number.
Standard Webform properties still apply: **Required**, **Default value**, **Size**, **Min/Max
length**, **Placeholder**, and conditional **states** (the plugin sets `states_wrapper = TRUE`).

Config equivalent (element inside a `webform.webform.*` config entity's `elements` YAML):

```yaml
my_rrn:
  '#type': webform_belgian_national_insurance_number
  '#title': 'Rijksregisternummer'
  '#required': true
  '#error_message': 'Please enter a valid Belgian national number.'
```

## Element properties (`getDefaultProperties()`)

From `src/Plugin/WebformElement/WebformBelgianNationalInsuranceNumber.php`, on top of the
`WebformElementBase` defaults:

| Property | Default | Meaning |
|---|---|---|
| `multiple` | `''` | Standard Webform multiple-value support. |
| `size` | `''` | Rendered field size (element `getInfo()` default `#size` is 15). |
| `minlength` | `''` | HTML minlength. |
| `maxlength` | `''` | HTML maxlength. |
| `placeholder` | `''` | Placeholder text. |
| `error_message` | `''` | **Required in the UI.** Shown when validation fails; passed to `$form_state->setError()`. |

## Rendering & the input mask

The form element (`src/Element/WebformBelgianNationalInsuranceNumber.php`) is a
`#type => 'textfield'`, `#input => TRUE`, `#size => 15`, themed as
`input__webform_belgian_national_insurance_number_element` with `form_element` wrappers.

`preRenderBelgianNationalInsuranceNumber()` sets `type = text`, adds
`data-inputmask-mask = '999999-999-99'`, attaches the library
**`webform/webform.element.inputmask`** (provided by the Webform module, not this one), and applies
the CSS classes `form-text`, `rrn-nrn`, `js-webform-input-mask`. The mask is a display/entry aid;
the authoritative check is server-side validation below.

`processBelgianNationalInsuranceNumber()` is a no-op pass-through (kept as an extension point).

## Validation (`validateBelgianNationalInsuranceNumber()`)

Runs as the element's `#element_validate` callback:

1. Returns immediately if `#webform_key` is empty.
2. Reads the value: `$rrn_nrn = $form_state->getValue($element['#webform_key'])`.
3. If the value is empty **and** the element is not `#required`, skips validation (optional empty
   field is allowed).
4. Computes the modulo-97 check on the 11 digits:
   - `$rrn_calc_value = (int)(substr($rrn_nrn, 0, 6) . substr($rrn_nrn, 7, 3))` — the first 9
     significant digits (birth date + sequence), skipping the separator position.
   - `$check_digit = (int)substr($rrn_nrn, 11, 2)` — the trailing 2 check digits.
   - `$remainder = $rrn_calc_value % 97`; `$remainder_2000 = ($rrn_calc_value + 2000000000) % 97`.
   - `$current_century_year = (int)("20" . substr($rrn_nrn, 0, 2))`.
5. Valid when `(97 - $remainder) == $check_digit` (person born before 2000) **or**
   `(97 - $remainder_2000) == $check_digit` **and** `$current_century_year <= (int)date("Y")`
   (person born 2000 or later). The year guard prevents a "20xx" interpretation that lies in the
   future.
6. On failure: `$form_state->setError($element, $element['#error_message'])`.

Note the offsets assume the value the mask produces — the check-digit substring is read from
position 11. The mask string `999999-999-99` is 13 characters including one dash; the submitted
value passed to validation is the digit string in these fixed positions. There is no format/length
pre-check before the `substr()` calls, so a badly shaped value simply fails the checksum comparison
(no fatal, no bypass).

## What it does NOT do

- No custom field formatter or view display — the stored value is shown as plain text via
  `WebformElementBase` defaults (HTML-escaped by the render system).
- No routes, controllers, services, permissions, config schema, or install/update hooks.
- No encryption or access restriction of the stored number — treat submissions containing a
  national identifier with the retention/access care that implies (a site-builder responsibility,
  not a module feature).
