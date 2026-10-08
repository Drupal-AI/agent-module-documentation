<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media/Document Notifier sends an email to configured recipients whenever a file whose extension matches a configured allow-list is saved.
---
On `hook_ENTITY_TYPE_insert` for file entities (`custom_email_notify_file_insert`), the module compares the new file's extension against the configured `allowed_file_types` list and, on a match, sends a mail through Drupal's mail manager to each address in `email_recipients`. The message body supports two literal placeholders — `[file_url]` (absolute file URL) and `[current-username]` (the file owner's account name). Subject and body come from config; `hook_mail` assembles the message.

Configuration lives at `/admin/config/custom-email-notify/settings` behind the `administer media document notifier` permission (marked *restrict access*). The settings form validates that extensions are bare alphanumeric tokens, that every recipient is a valid email address, and that the subject is non-empty and contains no CR/LF (header-injection guard). Because the permission controls outbound recipients and message content, grant it only to trusted administrators. Setup: enable the module, set allowed extensions (e.g. `pdf,docx`), add recipient addresses, and customise the subject/message.
---
- Notify a team when a PDF is uploaded to the site.
- Alert an inbox whenever a `docx` document is added.
- Configure the allowed file extensions that trigger a notification.
- Add one or more comma-separated notification recipients.
- Customise the notification email subject line.
- Customise the notification email body text.
- Insert the uploaded file's URL with the `[file_url]` token.
- Insert the uploader's username with the `[current-username]` token.
- Restrict who can change notifier settings via a dedicated permission.
- Validate recipient addresses before saving them.
- Prevent email-header injection by blocking line breaks in the subject.
- Notify a compliance address on every document upload.
- Send upload alerts to a shared distribution list.
- Turn off notifications by clearing the allowed extensions.
- Route notifications through the site's configured SMTP/mail system.
- Log a warning when no recipients are configured.
- Audit outbound file-upload notifications by role access.
