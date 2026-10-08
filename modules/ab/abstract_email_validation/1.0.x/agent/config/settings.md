<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & enabling validation

## Install / enable

Standard module. No dependencies. `composer require drupal/abstract_email_validation` then enable.
Optional: **Webform** (adds a per-element opt-in) and **Markdown** (renders the README on the help
page). You need an Abstract account and an email-verification API key (sign up at
`abstractapi.com/api/email-verification-validation-api`).

## Settings form

- Route `abstract_email_validation.settings_form`, path `/admin/config/system/abstract-email-validation`,
  permission `administer site configuration`. Form class
  `Drupal\abstract_email_validation\Form\AbstractEmailValidationSettingsForm` (extends `ConfigFormBase`,
  form id `abstract_email_validation_settings_form`). Menu link under *Configuration → System*
  (`abstract_email_validation.links.menu.yml`, weight 150).
- Editable config object: `abstract_email_validation.settings` (`getEditableConfigNames()`).

## Config object `abstract_email_validation.settings`

Install defaults in `config/install/abstract_email_validation.settings.yml`; schema in
`config/schema/abstract_email_validation.schema.yml`.

| key | type | default | meaning |
|-----|------|---------|---------|
| `api_url` | string | `''` | Abstract base URL (required in the form). The Guzzle GET target. |
| `api_key` | string | `''` | Abstract API key (required in the form). Sent as the `api_key` query param. |
| `custom_error_message` | text | `Your email address %email is invalid.` | Shown on failure; `%email` placeholder. |
| `user_registration_form_email_validation` | boolean | `false` | Validate the `user_register_form` / `user_form` mail field. |
| `detailed_settings.enabled` | boolean | `false` | Turn on the pick-your-checks mode. |
| `detailed_settings.smtp` | boolean | `false` | Require `is_smtp_valid`. |
| `detailed_settings.mx_found` | boolean | `false` | Require `is_mx_found`. |
| `detailed_settings.quality_score` | float | `0.8` | Minimum acceptable `quality_score` (form range 0.1–1.0). |
| `detailed_settings.deliverability` | string/bool | `''` | Require a truthy `deliverability`. |
| `blacklist.blacklist_email_option` | boolean | `false` | Enable the address blacklist. |
| `blacklist.emails` | text | `''` | Comma-separated blocked addresses. |
| `blacklist.blacklist_domain_option` | boolean | `false` | Enable the domain blacklist. |
| `blacklist.domains` | text | `''` | Comma-separated blocked domains. |

Note: schema declares the detailed group under key `detailed_settings.settings` while the form/code
read/write `detailed_settings.enabled|smtp|mx_found|quality_score|deliverability` — a schema/key
mismatch (config still works; schema validation of the detailed group is loose).

Field-level opt-in is stored as the field's third-party setting
`field.field.*.*.*.third_party.abstract_email_validation` (boolean) — see the constraint doc.

## Form behavior (`AbstractEmailValidationSettingsForm`)

- `validateForm()`: if detailed mode is on, at least one of smtp/mx_found/quality_score/deliverability
  must be checked; blacklist entries are validated with `FILTER_VALIDATE_EMAIL` / `FILTER_VALIDATE_DOMAIN`.
- `submitForm()`: clears then re-sets `api_key`, `api_url`, `blacklist`, `detailed_settings`, and
  writes the message + user-register flag. `sanitize()` splits comma lists and lowercases/trims values.

## Where validation gets turned on

1. **Per entity email field** — edit the field (Manage fields → field settings). The
   `hook_form_field_config_edit_form_alter` checkbox *"Enable the email validation using Abstract API."*
   sets `third_party_settings.abstract_email_validation`. On rebuild,
   `hook_entity_bundle_field_info_alter` adds the `AbstractEmailValidation` constraint to that field —
   but only for entity types `node`, `user`, `paragraph`, `taxonomy`, `menu`, `media`.
2. **User register/edit form** — set `user_registration_form_email_validation` on. `hook_form_alter`
   appends the `abstract_email_validation_custom_form_validate` element-validate callback to
   `account.mail` on `user_register_form` and `user_form`.
3. **Webform email element** — `hook_webform_element_info_alter` registers the `abstract_email_validation`
   property; the webform UI element form gains a checkbox; `hook_webform_element_alter` appends the
   validate callback when the property is TRUE on an `email` element.
4. **Custom form** — set `'#abstract_email_validation' => TRUE` on a `#type => email` element;
   `hook_form_alter` appends the validate callback (guarded by `abstract_email_validation_check_validation_added`).
