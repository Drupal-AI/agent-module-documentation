<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Devel Mail Logger is a development/QA tool that provides a Drupal mail backend (`MailInterface`) which saves every outgoing email to a database table instead of (or in addition to) sending it, plus a minimal admin UI to browse the captured mails.

---

The module defines a mail plugin `devel_mail_logger` (`@Mail` id, class `DevelMailLogger`) that implements `mail()` by inserting each message (recipient, subject, and the full `json_encode($message)` body/headers) into the `devel_mail_logger` DB table, and `format()` by converting the body to plain text. It is **not** active until you point Drupal's mail system at it — either via the Mail System module or by setting `$config['system.mail']['interface']['default'] = 'devel_mail_logger';` in `settings.php`. A report UI under `admin/reports/devel_mail_logger` lists logged mails (paged, sortable), `…/mail/{id}` shows a single mail's headers and body, `…/send` sends a test mail to the current user, and a delete form clears the table. Three permissions gate these: `devel_mail_logger access logged mail`, `devel_mail_logger send test mail`, and `devel_mail_logger delete test mail`. The stored `message` JSON is decoded and rendered in the single-mail view (body via `Markup::create(nl2br(...))`). Being a Development-package, developer-tagged tool, it is intended for local/staging use to inspect transactional email, not for production.

---

- Capture all outgoing site email to the database during local/staging development.
- Inspect the exact subject, recipient, headers, and body of transactional emails.
- Verify that a module actually sends the mail you expect (registration, password reset, order confirmation).
- Debug email templating/token replacement without a real SMTP server.
- Prevent test emails from reaching real users while QA-ing a flow.
- Send a test email to yourself to confirm the mail pipeline works (`admin/reports/devel_mail_logger/send`).
- Review a paged, sortable list of every logged message in the admin UI.
- Open a single logged mail to read its full headers and rendered body.
- Clear all captured mails between test runs via the delete form.
- Route mail through it globally via `settings.php` (`system.mail` default interface).
- Route only specific mail keys through it using the Mail System module.
- Confirm HTML-to-plain-text conversion of an email body (`format()`).
- Grant testers read-only access to logged mail via the access permission.
- Restrict who can send test mails or clear the log via dedicated permissions.
- Reproduce and share a captured email's content when filing a bug.
- Check that a queued/cron-triggered mail was actually generated.
- Use as a lightweight alternative to Mailhog/Mailpit when you cannot run an SMTP catcher.
