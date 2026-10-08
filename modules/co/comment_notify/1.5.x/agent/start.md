<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Notify — agent index

Emails commenters and entity authors when new comments are published. Adds an opt-in
checkbox to the comment form and default-preference checkboxes to the user account form.
Config UI: `/admin/config/people/comment_notify` (route `comment_notify.settings`).
Depends on core `comment` and `token`.

- **Settings config object, keys, per-bundle enable, mail templates, defaults** →
  [configure/settings.md](configure/settings.md)
- **Permissions (`administer comment notify`, `subscribe to comments`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `comment_notify.user_settings` service, the `comment_notify` DB table, hooks, routes** →
  [api/service-and-hooks.md](api/service-and-hooks.md)

Key facts:
- All global settings live in the config object **`comment_notify.settings`**
  (`bundle_types`, `available_alerts`, `enable_default`, `mail_templates`).
- A bundle is "enabled" when its `entity--bundle--field` id (e.g. `node--article--comment`)
  is in `comment_notify.settings:bundle_types`.
- Per-comment subscriptions → the `comment_notify` DB table; per-user defaults → `user.data`
  (`comment_notify` module key) via `UserNotificationSettings`.
