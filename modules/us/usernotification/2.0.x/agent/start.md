<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Send User Notification (usernotification) — agent index
**Admin authors one token-enabled email (subject + body) in config, then emails it to selected accounts via the "Send notification message to user(s)" bulk action on the People page.**

- **Version:** 2.0.x (release 2.0.2)
- **Core:** ^10 || ^11 || ^12
- **Dependencies:** `user`, `token`
- **Config route:** `usernotification.notification_settings` → `/admin/config/people/accounts/notification-setting`, permission `administer account settings`.
- **Config object:** `usernotification.settings` with keys `subject` and `message` (no install default — must be saved first). Tokens: `user`, `site`.
- **Action plugin:** `usernotification_action` (type `user`), label "Send notification message to user(s)"; appears in the Actions dropdown on `/admin/people`. `access()` requires edit access to each target user.
- **Delivery:** `hook_mail()` (key `user_notification_email`) token-replaces subject (plain text) and body, sends via mail manager in the recipient's preferred langcode, `Content-Type: text/html`, `From`/`Reply-To` = `system.site` mail.
- **No** custom permissions, no services, no Drush, no entities, no submodules. Config schema present (schemas the action config only).

See [configure/notification.md](configure/notification.md) and [api/action-and-mail.md](api/action-and-mail.md)
