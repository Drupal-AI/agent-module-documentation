<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Mentions Notifications (ckeditor_mentions_notifications) — agent index

Emails a user when they are `@`-mentioned **for the first time** in a CKEditor field. This module
is a thin add-on to **`ckeditor_mentions`**: it registers an event subscriber for that module's
`CKEditorEvents::MENTION_FIRST` event and, when the mentioned entity is a **User** who has opted in,
sends them a token-built email. Package `CKEditor`. Installed **1.0.1** (version dir `1.0.x`). Core
`^9.4.5 || ^10 || ^11`. License GPL-2.0-or-later. **Not covered** by Drupal's security advisory policy.

## Dependencies

- Drupal module: **`ckeditor_mentions`** (`ckeditor_mentions:ckeditor_mentions`, required — provides
  the mention detection and the events this module listens to). No `composer.json`, no PHP libraries,
  no config schema of its own. README states PHP 8.

## What it provides (from source — the module is ~2 PHP classes plus `.module`)

- **Event subscriber** `NotificationMentionEventsSubscriber` (`ckeditor_mentions_notifications.event_subscriber`,
  `.services.yml`) — subscribes to `ckeditor_mentions.mention` (`CKEditorEvents::MENTION_FIRST`),
  method `initiateNotification()`. Only acts when the mentioned entity is a `User` **and** the host
  entity is a `Node` or `Comment`; sends via `plugin.manager.mail`. See
  [events/notification-flow.md](events/notification-flow.md).
- **Admin config form** `CkeditorMentionsNotificationsConfigForm` (route
  `ckeditor_mentions_notifications.config_form` → `/admin/config/mentions_notifications`, permission
  `administer site configuration`, admin route). Edits the email **subject** and **body** stored in
  `ckeditor_mentions_notification.settings`. Menu link under System config. See
  [config/settings.md](config/settings.md).
- **Per-user opt-in** via `hook_form_alter` on `user_form` (`.module`): adds a radios element
  (`Enable` / `Disable`) whose value is saved through the **`user.data`** service under
  `ckeditor_mentions_notifications` / `mentions_notifications_settings_key`. Notifications fire only
  when this equals the string `"Enable"`. See [config/settings.md](config/settings.md).
- **Mail** `hook_mail()` key `send_ckeditor_mentions_notifications` — plaintext, `from` = site mail.
- **Tokens** (`hook_token_info` / `hook_tokens`): token type `ckeditor_mentions_notifications` with
  `entity_title`, `entity_url`, `entity_owner`. Used in the subject/body. See [config/settings.md](config/settings.md).

## No access role

Provides **no permissions** and **no plugin types**. Its only routes are the admin config form
(gated by `administer site configuration`) and the core user form. It does **not** provide the
mention-autocomplete endpoint — that lives in the upstream `ckeditor_mentions` module.

## Solution docs

- **Config form, tokens, per-user opt-in, default email** → [config/settings.md](config/settings.md)
- **Event subscriber, notification trigger, mail flow** → [events/notification-flow.md](events/notification-flow.md)
