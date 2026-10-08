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
- When a comment is published a subscribed recipient is only mailed if they can still
  `view` the commented entity; registered subscribers whose account no longer has an email
  address are skipped. The email address used for a registered subscriber is taken from
  their current account, not from the stored comment record.

## What changed in 1.6.x (vs 1.5.x)

Maintenance release (`8.x-1.5` → `8.x-1.6`); architecture and config are unchanged.
- Registered subscribers with no email address on their account are now skipped instead
  of causing an error, and a registered subscriber's mail is read from their account.
- The commented comment id is passed to `hook_mail` as `$params['cid']` (available to the
  `comment_notify_mail` mail key / mail-alter code).
- Fixed an undefined-array-key notice around the user account form's `comment_notify`
  preference default.
- The `hook_help` implementation is now an OOP hook in
  `src/Hook/CommentNotifyHooks.php` (`#[Hook('help')]`), with a `#[LegacyHook]` shim kept
  in `comment_notify.module`. Help-page text and coding-standards/static-analysis cleanups.
