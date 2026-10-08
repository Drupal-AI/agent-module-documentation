<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Manager overrides Drupal outbound emails with admin-managed, token-enabled HTML templates keyed by module:mail-key.

---

Email Manager lets site builders customise the subject and HTML body of Drupal's outbound emails from the admin UI instead of in code. It provides two config entities — Email Template and Email Key — and a Mail plugin that intercepts messages and swaps in the matching template.

Email keys are discovered as `module:key` pairs (with a `hook_email_manager_keys_alter` hook to add ones auto-discovery misses); a template is bound to a key and edited in CKEditor with Token support. The `EmailManagerMail` Mail plugin (extending the core mail system) looks up the template for the `module`/`key` of each message, runs token replacement (including the module's own `email_manager:module` / `email_manager:key` tokens), and formats the body as HTML. Everything is gated behind the `administer email templates` permission (marked restrict access).

Typical setup: enable the module, set `email_manager` as the mail plugin for the relevant keys (or globally), define keys, then author templates per key. It changes how mail is rendered/sent; it does not add public endpoints.

---
- Customise the body of a specific Drupal email (e.g. user registration).
- Override an email subject line from the admin UI.
- Author email bodies in CKEditor with a WYSIWYG.
- Insert tokens into email templates.
- Bind a template to a `module:key` mail key.
- Discover available mail keys automatically.
- Add missing keys via `hook_email_manager_keys_alter`.
- List and manage all email templates.
- List and manage email keys.
- Send Drupal emails as formatted HTML.
- Use `email_manager:module` / `email_manager:key` tokens.
- Restrict template management to trusted admins.
- Provide branded transactional emails.
- Edit a template without touching code or hook_mail.
- Preview which module/key an email belongs to.
- Standardise email styling across modules.
- Localise email content per template.
- Swap the mail plugin to EmailManagerMail for a key.
- Maintain templates as exportable config entities.
- Roll out consistent notification emails site-wide.