# Mailer Storage — agent index

Submodule of Mailer (dep: `mailer`). Persists every mail sent via a MailerMail plugin as a
`mailer_storage` content entity, and adds a resend action. Enabling it is the whole setup —
`MailerMailPluginBase::send()` auto-saves when this module is on.

- api/storage.md — the `mailer_storage` entity + `mailer_storage_type` bundle, auto-capture
  on send, the `resend_email` plugin / resend form, routes, permissions, programmatic use.

Quick facts:
- Content entity `mailer_storage` (revisionable). Fields: `label`, `to` (email), `subject`,
  `message` (text_long, full_html), `uid` (author), `created`. Base table `mailer_storage`.
- Bundle config entity `mailer_storage_type`; ships a `default` bundle (config/install).
- MailerMail plugin `resend_email` (config `MailerMailConfigBase`).
- Collection: `/admin/content/mailer-storage`. Type collection: `/admin/structure/mailer_storage_types`.
- Permissions: `view mailer_storage`, `edit mailer_storage`, `delete mailer_storage`,
  `create mailer_storage`, `administer mailer_storage types` (admin).
- Provides permissions + config schema. No Drush, no plugin types, no library deps.
- Caveat: declared `configure` route `mailer_storage.send_mail_form` does NOT exist in 2.0.x
  (dangling reference in the info.yml).
