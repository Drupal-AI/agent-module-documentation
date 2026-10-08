# Contact Emails — agent index

Gives each core **contact form** one or more configurable emails (subject, body, recipients,
reply-to) via a `contact_email` content entity, replacing core's single-recipient behaviour.
Requires `contact` + `contact_storage`. One permission, one global setting, no Drush, no plugins.

- **Manage the emails on a form (UI, routes, entity fields, the global setting)** →
  [configure/manage-emails.md](configure/manage-emails.md)
- **Create/read contact emails in code, the storage helper, and how core mail is suppressed** →
  [api/programmatic.md](api/programmatic.md)

Key facts:
- Configure route (`configure`): `entity.contact_email.full_collection` → `/admin/structure/contact/emails`.
- Per-form list: `entity.contact_email.collection` → `/admin/structure/contact/manage/{contact_form}/emails`.
- Permission: `manage contact form emails` (settings page needs core `administer contact forms`).
- Global setting: `contact_emails.settings` key `allow_charset_utf_8` (boolean).
- When a form has ≥1 `contact_email`, `hook_mail_alter()` sets `message['send'] = FALSE` on core's
  contact mail and the form's core recipient/reply fields are hidden — the module sends instead.
