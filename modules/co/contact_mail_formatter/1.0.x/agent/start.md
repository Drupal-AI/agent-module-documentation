<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Mail Formatter (contact_mail_formatter) — agent index
**HTML email templates + token support for core contact form messages, configured per contact form.**

- **Version:** 1.0.x (php: 7.4)
- **Core:** ^9 || ^10 || ^11
- **Requires:** drupal:contact, drupal:token
- **Config:** third-party settings on the contact form entity (`enable_mail_formatter`, `template`, `mail_html`)
- **Hooks:** form alter on `contact_form_add/edit_form`; `hook_mail_alter()` on `contact_page_mail` (token replace + `text/html`); `token_info_alter` adds `site:logo`/`site:logo-url`
- **Templates:** `template_cmf1..3` + `custom`; editor is CKEditor `full_html`
- **Security:** No routes/permissions/services. Configuration limited to core contact-form admin access; templates authored via `full_html` by trusted admins. `hook_mail_alter` uses `token->replace()` with default (sanitizing) behavior — no `sanitize=>FALSE` — so submitter field tokens are HTML-escaped in the mail.

See [configure/templates.md](configure/templates.md)