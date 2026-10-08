<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VAT Number (vat_number) — agent index

Provides a **field type** (`vat_number`) for storing and validating **European VAT registration
numbers**, plus a matching **form render element** (`#type => 'vat_number'`) and a **Webform element**
(shipped by the `webform_vat_number` submodule). Validation has two tiers, both implemented in
`VatNumberController`: an offline **format/regex check** keyed on the two-letter country prefix, and
an optional online **VIES** check that queries the European Commission's SOAP service to confirm the
number is registered for cross-border EU trade. VIES is **off by default** and is turned on per field
widget or per Webform element.

The module has **no routes, no services, no permissions, no settings page and no drush** — it is
entirely Field API + render-element plugins. The class named `Drupal\vat_number\Controller\VatNumberController`
is **not** a route controller: it is a plain validation helper instantiated with
`new VatNumberController($vat)` from the element/widget validate callbacks.

- Depends on: nothing outside Drupal core (`composer.json` `require` is empty; `vat_number.info.yml`
  declares no `dependencies`). The `webform_vat_number` submodule depends on `webform:webform`.
- Runtime: the VIES tier needs the **`ext-soap` PHP extension** — enforced by `hook_requirements()`
  in `vat_number.install` (`REQUIREMENT_ERROR` when the extension is missing).
- Core: `^8 || ^9 || ^10 || ^11` (info.yml). Package: `Field types`. Version `2.1.1`.
- Config schema: yes (`field.widget.settings.vat_widget`). Permissions: none. Drush: none. Defines
  **no new plugin types** — it only implements core Field / FormElement / WebformElement plugin types.

## What you'd do → where

- **Add a VAT field to an entity and configure the widget (enable VIES, fail-if-unavailable)** →
  [fields/field.md](fields/field.md)
- **Use `#type => 'vat_number'` in a custom form, add the Webform VAT element, or set the
  formatter** → [fields/field.md](fields/field.md)
- **Call the validator from code / understand the format regexes, the VIES SOAP call, and the
  `fail_if_vies_unavailable` setting** → [api/validation.md](api/validation.md)

## Key facts (real machine names)

- Field type: `vat_number` (`src/Plugin/Field/FieldType/VatNumber.php`), `default_widget = vat_widget`,
  `default_formatter = vat_formatter`; storage = single `value` column (`type: text`, `size: medium`,
  nullable).
- Widget: `vat_widget` (`src/Plugin/Field/FieldWidget/VatNumberWidget.php`) — settings
  `validate_vies` (bool, default `FALSE`) and `fail_if_vies_unavailable` (bool, default `FALSE`).
- Formatter: `vat_formatter` (`src/Plugin/Field/FieldFormatter/VatNumberFormatter.php`) — renders the
  stored value inside a `<p>` via the core `html_tag` element (core runs `Xss::filterAdmin` on it).
- Form render element: `vat_number` (`src/Element/VatNumber.php`, extends `Textfield`) — properties
  `#validate_vies` (default `FALSE`) and `#fail_if_vies_unavailable` (default `FALSE`); registers an
  `#element_validate` callback.
- Validation helper: `Drupal\vat_number\Controller\VatNumberController` —
  `check(bool $validate_vies = TRUE, bool $fail_if_vies_unavailable = TRUE): array` returns
  `['status' => bool, 'message' => \Drupal\Core\StringTranslation\TranslatableMarkup|null]`; also a
  public `euCountries(): array`.
- Config schema key: `field.widget.settings.vat_widget` (`config/schema/vat_number.schema.yml`).
- VIES endpoint (hardcoded, not user-controllable):
  `http://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl`, SOAP operation `checkVat`.
- Submodule `webform_vat_number`: Webform element `vat_number`
  (`modules/webform_vat_number/src/Plugin/WebformElement/VatNumber.php`, category "Advanced
  elements"), same two properties; depends on `vat_number` + `webform`.
