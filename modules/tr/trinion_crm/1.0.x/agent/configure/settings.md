<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Trinion CRM

Route `trinion_crm.settings` at `/admin/config/crm/settings` (menu under `trinion_base.config`), permission `administer site configuration`. Config object: `trinion_crm.settings`.

## Fields (SettingsForm)
- `sdelki_start_nomer` — integer, the starting number for automatic deal numbering.
- `lid_poluchatel_uvedomleniya` — user entity_autocomplete (multi, `#tags`); the users emailed when a new lead is captured from a contact form.

## Other config keys consumed in code (set elsewhere / by install)
Read by `trinion_crm_form_alter` and the contact-form submit handler:
- `status_obrabotki_lida_noviy_tid` — taxonomy tid for a new lead's processing status.
- `lead_metod_vhozhdeniya_email_tid` — tid for the "email" lead-entry method.
- `lead_metod_vhozhdeniya_form_tid` — tid for the "form" lead-entry method (used when a contact form creates a lead).

## Lead capture
`trinion_crm_contact_form_submit` runs on any `contact_message_*_form`; it serializes the submitted fields into a `lead` node's `field_tl_text`, sets entry-method/status from the config tids above, saves the lead, and mails the configured recipients via `hook_mail` key `lid_manager_notice`.

## Document numbering
`CRMHelper::getNextDocumentNumber($type)` returns the next per-year sequential number for `lead`/`sdelki` titles (falls back to `sdelki_start_nomer`/1). Wired as the default title on new `sdelki` and `lead` node forms.
