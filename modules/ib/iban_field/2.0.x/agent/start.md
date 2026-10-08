<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IBAN Field (iban_field) — agent index

Adds an IBAN **field widget** for core `string` (single-line text) fields: a plain textfield input
that validates the entered value as an International Bank Account Number (country, length, mod-97
checksum) and normalises it to uppercase on submit. It has **no field type and no formatter of its
own** — values are stored in an ordinary `string` field and rendered by whatever formatter that field
uses. Depends on core `field`. No settings page, no permissions, no Drush, no services. Ships config
schema for the widget settings.

Submodule (its own docs): `webform_iban_field` — the same IBAN validation as a Webform element →
[../../modules/webform_iban_field/2.0.x/agent/start.md](../../modules/webform_iban_field/2.0.x/agent/start.md)

- **Apply the IBAN widget to a field, its settings, and how validation works** →
  [fields/iban-widget.md](fields/iban-widget.md)

Key facts:
- Widget plugin `@FieldWidget(id = "iban_field", label = "IBAN Field")` →
  `Drupal\iban_field\Plugin\Field\FieldWidget\IbanFieldWidget` (extends `WidgetBase`),
  `field_types = { "string" }`.
- Widget settings (schema `field.widget.settings.iban_field`): `size` (integer, default 60) and
  `placeholder` (label, default `''`).
- Validation: static `IbanFieldWidget::validateIbanElement()`, wired as `#element_validate`, runs the
  Symfony `Symfony\Component\Validator\Constraints\Iban` constraint; on violation sets the form error
  "This is not a valid International Bank Account Number (IBAN)."; empty input is allowed; valid input
  is uppercased before storage.
- Validation lives in the widget only, so values written via REST/JSON:API or programmatically are not
  IBAN-checked at the storage layer.
