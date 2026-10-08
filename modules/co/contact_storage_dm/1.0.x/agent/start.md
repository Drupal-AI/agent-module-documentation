<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Storage Disable Mail (contact_storage_dm) — agent index

**Adds a per-contact-form "Disable Mail Send" checkbox so a form stores its submissions (via Contact Storage) without sending the notification email.** "DM" = Disable Mail.

- **Version:** 1.0.0 (info.yml `name: 'Contact Storage Disable Mail'`)
- **Core:** `^9.1 || ^10 || ^11`
- **Dependencies:** `contact_storage:contact_storage` (which builds on core `contact`)
- **License:** GPL-2.0-or-later

## Mechanism (whole module is `contact_storage_dm.module`, 53 lines)

- **`hook_form_FORM_ID_alter()` → `contact_storage_dm_form_contact_form_form_alter()`** — on the contact form config-entity `add`/`edit` form only, adds a `checkbox` `contact_storage_dm` titled *Disable Mail Send*, defaulting to the form's third-party setting `contact_storage_dm.disabled` (FALSE). Registers an `#entity_builders` callback.
- **Entity builder `contact_storage_dm_contact_form_builder()`** — writes the checkbox value back via `$contact_form->setThirdPartySetting('contact_storage_dm', 'disabled', …)`.
- **`hook_mail_alter()`** — when a message carries `params['contact_form']` and that form's `contact_storage_dm.disabled` third-party setting is TRUE, sets `$message['send'] = FALSE` so Drupal skips delivery. Submission storage is unaffected.

## Config

- No routes, no `*.routing.yml`, no `*.permissions.yml`, no `*.install`, no services, no templates, no Drush.
- Config schema (`config/schema/contact_storage_dm.schema.yml`): `contact.form.*.third_party.contact_storage_dm` mapping with one boolean `disabled`. The flag is stored on the existing contact form config entity — the module defines no config entity of its own.

## Where the setting lives

The checkbox appears on **Structure → Contact forms → *(form)* → Edit** (`/admin/structure/contact`). Access to that form is governed by core's contact-form entity permissions, not by this module. There is no dedicated settings page.

**Security:** the module has no routes, endpoints, SQL, listing/rendering of submitter data, or permissions of its own; it only toggles a boolean third-party setting on the contact form (edited through core's access-gated contact form edit form) and suppresses mail delivery based on it. It does not touch stored-submission access.
