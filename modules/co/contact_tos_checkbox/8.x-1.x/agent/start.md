<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Terms Of Service Checkbox (contact_tos_checkbox) — agent index
**Adds a required consent checkbox to core Contact's site-wide feedback form.**

- **info.yml name:** `Contact Terms Of Service Checkbox`
- **Version:** 8.x-1.x (packaged `8.x-1.3`)
- **Core:** `^10.1 || ^11 || ^12`
- **Package:** `rdoepner`
- **Depends:** `drupal:contact` (core Contact)
- **Configure:** `/admin/config/user-interface/contact-tos-checkbox` (route `contact_tos_checkbox.settings`)
- **Permission:** `administer contact tos checkbox`

## What it does
When enabled in config, injects a single `#required` checkbox into core Contact's
site-wide **feedback** form (`contact_message_feedback_form`). Because the field is
required, the visitor cannot submit until it is ticked — an explicit consent gate
(GDPR / privacy / terms). It does not add a database field or store the consent
separately; the checkbox is purely a submit-time gate on the standard contact message.

## Mechanism
- `contact_tos_checkbox.module` — thin `#[LegacyHook]` bridge:
  `contact_tos_checkbox_form_contact_message_feedback_form_alter()` delegates to the service.
- `src/Hook/ContactTosCheckboxHooks.php` — `#[Hook('form_contact_message_feedback_form_alter')]`
  reads `contact_tos_checkbox.settings`; if `feedback.enabled` is TRUE, adds a
  `#type => container` wrapper (`#weight` 75) holding a `#type => checkbox` with
  `#title` = `feedback.label`, `#description` = `feedback.description`,
  `#required => TRUE`, `#default_value => FALSE`.
- `src/Form/ContactTosCheckboxSettingsForm.php` — `ConfigFormBase` editing the three
  config keys (`feedback_enabled` textfield/checkbox → `feedback.enabled`,
  `feedback_label` textfield → `feedback.label` (required), `feedback_description`
  textarea → `feedback.description` (required)).

## Config
`contact_tos_checkbox.settings` (config_object, schema in `config/schema/`):
- `feedback.enabled` (boolean) — toggle the checkbox on the feedback form.
- `feedback.label` (label) — checkbox title/consent statement.
- `feedback.description` (text) — help text under the checkbox; may include an HTML link.

Shipped defaults (`config/install/`) are **German** and link to `/datenschutz`:
label `Datenschutzerklärung`, description
`Ja, ich habe die <a target="_blank" href="/datenschutz">Datenschutzerklärung</a> gelesen und akzeptiert.`
Most sites edit these to their own language/copy.

## Rendering note
Both the checkbox `#title` and `#description` are output through core's form-element
render pipeline, which filters them with `Xss::filterAdmin()` — so an admin-supplied
HTML link (`<a>`, `<em>`, etc.) renders, while scripts, event handlers and
`javascript:` protocols are stripped by core. Editing the label/description requires
the `administer contact tos checkbox` permission.

## Files
- `contact_tos_checkbox.info.yml`, `composer.json`
- `contact_tos_checkbox.module`, `src/Hook/ContactTosCheckboxHooks.php`
- `src/Form/ContactTosCheckboxSettingsForm.php`
- `contact_tos_checkbox.routing.yml`, `contact_tos_checkbox.permissions.yml`,
  `contact_tos_checkbox.services.yml`, `contact_tos_checkbox.links.menu.yml`
- `config/schema/contact_tos_checkbox.schema.yml`, `config/install/contact_tos_checkbox.settings.yml`

No submodules, no Drush commands, no custom services beyond the autowired hook class,
no templates, no `.install`, no `.api.php`.

## Status
Maintainer marks the project **Unsupported / Obsolete**, **not covered** by the
Drupal security advisory policy (see `data.json`).
