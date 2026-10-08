<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Contact (entity_contact) — agent index
**Fieldable contact forms + stored, handler-processed submissions.**

- **Version:** 2.2.x (release 2.2.0)
- **Core:** ^10.1 || ^11
- **Depends:** drupal:text
- **Composer:** requires `phpoffice/phpspreadsheet:^3.9` (used by the XLSX export submodule)
- **Configure:** `entity.entity_contact_form.collection` (/admin/content/entity-contact)
- **Entities:** `entity_contact_form` (config bundle), `entity_contact_message` (content, fieldable)
- **Key services:** `plugin.manager.entity_contact.submission_handler`; `entity_contact_email.mailer` (submodule)
- **Key permissions:** `access entity contact form` (public submit), `administer entity contact forms`, `view/administer entity contact form submissions`, `administer entity contact form settings`
- **Submodules:** entity_contact_email, entity_contact_route, entity_contact_export(_xlsx), entity_contact_search_api, entity_contact_example_submission_handler

**Mechanism:** each form is a config bundle; each submission is an `entity_contact_message` content entity with your own fields. The public submit page is gated by the dedicated `access entity contact form` permission (never `access content`). On insert (`entity_contact_entity_insert`) every message runs through the submission-handler manager; if the form's *store submission* flag is off the message is deleted after handling. `entity_contact_cron` purges expired messages. The message form applies a flood limit/interval (skipped for `administer entity contact forms`) and IP storage is an off-by-default toggle. Each new message also captures UTM/GCLID marketing parameters and a submission URL from the request/referer into read-only base fields.

**Security posture:** the public submission route is gated by a dedicated `access entity contact form` permission (not `access content`); flood limit/interval throttles anonymous submissions; e-mail recipients are admin-configured static addresses plus only admin-chosen message fields (email/list_string types), each value re-validated with `EmailValidator`; subject/body are admin templates run through Token and the core mail manager. Admin, submission-view, export and e-mail-config routes are permission- or entity-access-gated.

See [configure/forms.md](configure/forms.md).
