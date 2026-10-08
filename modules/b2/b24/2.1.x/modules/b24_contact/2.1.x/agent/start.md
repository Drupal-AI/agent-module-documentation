<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_contact (b24_contact) — agent index

Submodule of **[b24](../../../../agent/start.md)**. Exports core **contact-form**
(`contact_message`) submissions to Bitrix24 **leads**. Depends on `b24` and core `contact`. Package
`bitrix24`. Configure route `b24_contact.settings_form` (`/admin/config/b24/contact`, permission
`administer b24 configuration`).

## What it provides

- **`hook_mail_alter()`** (`b24_contact.module`) — the export trigger. On a `contact` module mail,
  reads `b24_contact.settings` for the submitted form; if `forms.<id>.status` is on, iterates the
  `forms.<id>.mapping`: for each Bitrix24 field, a value comes from a `contact_message` field
  (`$submission->get($int_field)->getString()`) or, when mapped to `custom`, from a
  token-replaced `<field>_custom` string; wraps `crm_multifield` values; then
  `RestManager::addLead($fields)`.
- **`SettingsForm`** (`src/Form/SettingsForm.php`) — one vertical tab per contact form: an
  *Enable export* checkbox plus a mapping fieldset built by `FormHelper::getMappingSelects()`
  (Bitrix24 field → contact_message field/token/custom). `validateForm` enforces required
  Bitrix24 fields; `submitForm` writes `b24_contact.settings`.
- **Config schema** (`config/schema/b24_contact.schema.yml`): `b24_contact.settings.forms` is a
  sequence of `b24_contact_form` (`status` int + `mapping` seq of strings).
- Attaches the `b24/vertical-tabs` library.

No separate solution doc — the mechanism above is the whole module.
