<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media/Document Notifier (custom_email_notify) — agent index

**Emails configured recipients when a file with a matching extension is uploaded.** Project machine name: `medianotify`.

- **Version:** 1.0.x (1.0.6)
- **Core:** ^10 || ^11
- **Depends:** file, media
- **Route:** `/admin/config/custom-email-notify/settings` (`custom_email_notify.settings_form`) — permission `administer media document notifier` (restrict access).
- **Config:** `custom_email_notify.settings` (`allowed_file_types`, `email_recipients`, `email_subject`, `email_message`).
- **Hooks:** `hook_file_insert` triggers mail; `hook_mail` builds it; tokens `[file_url]`, `[current-username]`.
- **Security:** settings route is permission-gated; form validates extensions, email addresses and blocks CR/LF in the subject (header-injection guard); no anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md).
