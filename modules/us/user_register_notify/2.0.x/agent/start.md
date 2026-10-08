<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Registration Notification (user_register_notify) — agent index

Emails chosen roles and/or explicit addresses when a user account is **created, updated, or
deleted**. Implemented purely with core entity hooks (`hook_user_insert/update/delete`) plus
`hook_mail` — no service, no plugin, no cron, no Drush. Depends on core `user` and `token`.
Core requirement `^10.3 || ^11`. Newest release on this branch is **2.0.0-beta2** (no stable
release exists yet).

Settings route: `user_register_notify.settings` →
`/admin/config/people/user_register_notify/settings`.
Permission: `administer user_register_notify configuration`.

- **Turn notifications on, pick recipients/events, edit subject+body templates and tokens, set
  From/Reply-to overrides, enable logging** → [configure/settings.md](configure/settings.md)
- **The one permission that gates the settings form** → [permissions/permissions.md](permissions/permissions.md)
- **How the send actually fires at runtime (hooks, recipient resolution, role filtering, uid-1
  skip, hook_mail, header override, the custom OG token)** → [hooks/notifications.md](hooks/notifications.md)

Key facts:
- Single config object `user_register_notify.settings`. Ships **`type: disabled`** and empty
  `events`, so nothing is sent until an admin enables it.
- `type` is one of `disabled` / `role` / `custom` / `both`. `events` is a subset of
  `create` / `update` / `delete`.
- Recipients: `mail_to` (comma-separated addresses) and/or `roles` (every active user holding a
  selected role). Per-event include/exclude role filter via `{created,updated,deleted}_roles` +
  `{created,updated,deleted}_roles_mode`.
- Message templates: `{created,updated,deleted}_subject` and `{created,updated,deleted}_body`,
  rendered with `\Drupal::token()->replace()` over the `user` token type (callback
  `user_mail_tokens`). Default templates carry only `[user:*]`, `[current-user:*]`, `[site:*]`,
  `[current-date:short]`.
- Mail keys: `user_register_notify_create` / `_update` / `_delete` (full message ids
  `user_register_notify_user_register_notify_create` etc.).
- Defines one token `[user:user-register-notify-og-groups]` (needs the contrib `og` module).
- `enable_logging` (bool) writes a watchdog notice per send.
