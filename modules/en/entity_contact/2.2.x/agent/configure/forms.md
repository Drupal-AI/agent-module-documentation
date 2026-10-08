<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Entity Contact

## Create a form and store submissions
1. /admin/content/entity-contact → **Add contact form** (`entity_contact.form_add`, perm `administer entity contact forms`).
2. Add fields to the `entity_contact_message` entity (Field UI) — these are the form fields.
3. On the form, set *store submission* on/off. Off = message handled then deleted on insert.
   Optionally set `remove_stored_submissions_after` (a `strtotime()` string) to auto-expire stored messages; `entity_contact_cron` purges them.

## Expose the public form
Grant `access entity contact form` (form entity `view` op). The submit form is reached via the
`entity_contact_message` add form; the `entity_contact_route` submodule adds a standalone URL
`/contact-form/{entity_contact_form}` (same permission). The message form offers a **Preview**
button when a `preview` display component is present.

## E-mail on submission (entity_contact_email submodule)
- Enable `entity_contact_email`; on a form choose **E-mails** → add an `entity_contact_email`.
- Recipients = static addresses + optional message field(s). Field recipients are limited to
  `email`/`list_string` fields explicitly named in config; each resolved value is validated with
  `EmailValidator`; `list_string` fields map allowed-value → address.
- Subject/body are Token-replaced (`entity_contact_email`, `entity_contact_message`,
  `entity_contact_form` token types; `[entity_contact_message:list-fields]` renders all fields in
  the `mail` view mode). New `file` fields are auto-registered to attach to the mail.

## Flood + IP (Settings form, `entity_contact_form.settings`)
`administer entity contact form settings` → set flood `limit`/`interval` (defaults 5 / 3600s);
toggle `entity_contact_message_store_ip_address`. Flood is enforced in `validateForm` for anyone
without `administer entity contact forms`.

## Submission handlers
Implement a `SubmissionHandlerPlugin` (see `entity_contact_example_submission_handler`); the manager
`plugin.manager.entity_contact.submission_handler` runs every handler on message insert. Each handler
also gets an admin settings tab per form (routes from `Routing\Router::routes`, perm
`administer entity contact forms`).

## Export submissions (entity_contact_export / _xlsx)
`/admin/content/entity-contact/manage/{form}/…` export form; access requires the form to store
submissions plus `view entity contact form submissions` OR `export entity contact messages`. Layout
and format are pluggable (CSV core, XLSX via `entity_contact_export_xlsx` + phpspreadsheet); the
export query uses `accessCheck(TRUE)`.
