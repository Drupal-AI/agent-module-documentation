<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maillog captures a copy of every outgoing email in a database table for later inspection, can display sent mails on-screen, and can suppress actual delivery — ideal for development, staging, and debugging.

---

Maillog registers a core Mail plugin (`maillog`) and, on install, sets it as the site's default mail interface (`system.mail` `interface.default = maillog`). The plugin formats mail exactly like core `PhpMail`, then, depending on `maillog.settings`, stores the message (headers, from/to, subject, body, timestamp) in the `maillog` database table, optionally echoes a verbose copy to users with the *View Maillog* permission, and only actually delivers the mail when `send` is true — so on a dev/staging box you can turn delivery off entirely. Logged mails are browsable through a bundled View at `/admin/reports/maillog`, with per-message details and delete actions. Options let you trim stored bodies to 512 characters, strip base64 data from bodies, and notify visitors when delivery is off or mail was logged. A cron cleanup can prune old entries by age or by count, and a Drush command `maillog:clear` truncates the log. The module defines three permissions (view/delete/administer maillog) and a settings form at `/admin/config/development/maillog`. Uninstalling restores the default mail interface to `php_mail`.

---

- Inspect exactly what emails your site sends without a real mail server, during development.
- Stop a staging or QA site from emailing real users by disabling delivery (`send = false`).
- Debug a broken registration or password-reset email by reading its stored headers and body.
- Keep an archival copy of all outgoing mail in the `maillog` table for auditing.
- View sent messages in the admin UI at `/admin/reports/maillog`.
- See a verbose dump of each mail on-screen as it is "sent" (for users with *View Maillog*).
- Confirm that a contact form or webform actually triggers an email and with what content.
- Verify HTML mail markup produced by a theme or mail module before going live.
- Prevent accidental notification storms after cloning production to a local environment.
- Clear the whole log quickly with `drush maillog:clear`.
- Automatically prune mail logs older than N days via cron.
- Automatically keep only the most recent N mail log entries via cron.
- Trim large stored bodies to 512 characters to keep the database small (`body_trimmed`).
- Strip base64-encoded inline images/attachments out of stored bodies (`base64_remove`).
- Notify anonymous/visitor users that delivery is currently disabled (`nosend_notify`).
- Notify visitors that their message was logged (`log_notify`).
- Grant support staff read-only access to sent mail with the *View Maillog* permission.
- Let a developer delete individual logged messages with the *Delete* permission.
- Reproduce a customer's "I didn't get the email" issue by checking whether it was logged.
- Combine with the MailSystem module to control which mail backend Maillog wraps.
- Hardcode Maillog behaviour per environment in `settings.php` (`$config['maillog.settings']['send'] = FALSE;`).
- Point the site's default mail interface at Maillog automatically (set on install).
- Restore normal PHP mail delivery simply by uninstalling the module.
- Provide a safe email sandbox for automated tests and demos.
