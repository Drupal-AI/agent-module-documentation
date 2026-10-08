<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Media/Document Notifier

Route `custom_email_notify.settings_form` → `/admin/config/custom-email-notify/settings` (permission `administer media document notifier`).

Config `custom_email_notify.settings`:

| Key | Notes |
|---|---|
| `allowed_file_types` | Comma list of bare extensions, e.g. `pdf,docx` (validated `^[a-z0-9]+$`). |
| `email_recipients` | Comma list of email addresses (each validated). |
| `email_subject` | Required, must not contain `\r`/`\n`. |
| `email_message` | Body; supports `[file_url]` and `[current-username]`. |

Behaviour: `custom_email_notify_file_insert()` fires on every new file entity; if the extension matches, it mails each recipient via `plugin.manager.mail` (key `notify_email`). Delivery uses the site's configured mail system (add an SMTP module for real delivery). If no recipients are set it logs a warning and sends nothing.

```bash
drush cset custom_email_notify.settings allowed_file_types 'pdf,docx' -y
drush cset custom_email_notify.settings email_recipients 'ops@example.com' -y
```
