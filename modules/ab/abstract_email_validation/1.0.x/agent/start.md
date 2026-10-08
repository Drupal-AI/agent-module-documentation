<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Abstract API Email Validator (abstract_email_validation) — agent index

Integrates the third-party **Abstract** email verification/validation API into Drupal email
fields and forms. Opt-in per field/element: a flagged email value is checked against a local
blacklist, then sent to Abstract, and accepted/rejected on the deliverability response.
Package **Email**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.
**No dependencies** (Webform and Markdown are optional soft integrations via hooks).

## What it provides

- **Config form + route** `abstract_email_validation.settings_form` at
  `/admin/config/system/abstract-email-validation` (`src/Form/AbstractEmailValidationSettingsForm.php`),
  permission `administer site configuration`. Menu link in `*.links.menu.yml`. Writes config object
  `abstract_email_validation.settings`. **No custom permissions, no Drush.**
- **Validation constraint plugin** `AbstractEmailValidation`
  (`src/Plugin/Validation/Constraint/AbstractEmailValidationConstraint.php` +
  `...ConstraintValidator.php`) — attached to email fields whose third-party setting is on.
- **Services** (`*.services.yml`):
  - `abstract_email_validation.api` → `Http\AbstractApi` — one Guzzle GET to the configured Abstract URL.
  - `abstract_email_validation.validator` → `Validate\EmailValidator` — blacklist + response-rule decision.
  - `abstract_email_validation.constraint_validator` → the constraint validator (tagged).
- **Hooks** (`abstract_email_validation.module`): `hook_entity_bundle_field_info_alter` (adds the
  constraint to opted-in email fields on node/user/paragraph/taxonomy/menu/media),
  `hook_form_field_config_edit_form_alter` (the per-field opt-in checkbox → `third_party_settings`),
  `hook_form_alter` (custom `#abstract_email_validation` elements + user register/edit form),
  `hook_webform_element_info_alter` / `hook_webform_element_alter` / webform UI form alter (Webform
  opt-in), and `hook_help`.

## Solution docs

- **Configuration — settings form, config object & schema, how to enable validation on each surface** →
  [config/settings.md](config/settings.md)
- **Validation pipeline — the API service, EmailValidator rules, the constraint & the validate callback** →
  [api/validation.md](api/validation.md)

## Key facts

- Validation is **opt-in**: nothing is validated until a field's third-party setting (or an
  element's `#abstract_email_validation` property, or the user-register global setting) is enabled
  AND a valid Abstract base URL + API key are configured.
- Default accept rule (detailed mode off): `is_smtp_valid` AND `deliverability` AND
  `quality_score >= 0.8`. Detailed mode lets the admin pick any subset of SMTP / MX-found /
  deliverability / custom quality-score threshold.
- Blacklist (email list and/or domain list) is checked **before** the API call and short-circuits it.
