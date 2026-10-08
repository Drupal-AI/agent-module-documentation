<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Contact — agent index

Two **display formatters for the core `email` field** that render a contact form instead of
showing the address: `email_contact_link` (link/modal to a form) and `email_contact_inline`
(embedded form). No global settings page (`configure: null`), no permissions (access = entity +
field view access), no plugins, no Drush.

- **Apply a formatter to an email field, all formatter setting keys, modal & redirect options,
  config shape** → [configure/formatters.md](configure/formatters.md)
- **Route, hook_mail, the email-body/token behaviour, the AJAX-command event, and the
  `email_contact_get_emails_from_field()` helper** → [api/integration.md](api/integration.md)

Key facts:
- Formatter ids: **`email_contact_link`**, **`email_contact_inline`** (field type `email`).
- Configured per field in *Manage display* (`entity_view_display` config `content.<field>.type`).
- Sends via `hook_mail()` key `contact`; recipient = the field's address(es); reply-to = the
  submitter; the address is never displayed.
- `token` module is an optional dependency (tokens in the additional message).
