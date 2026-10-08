<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Notify — service, storage, hooks & routes

## Service: `comment_notify.user_settings`

Class `Drupal\comment_notify\UserNotificationSettings`. Wraps per-user default preferences,
stored in **`user.data`** under the module name `comment_notify` (keys `comment_notify` and
`entity_notify`). Constructor args: `@user.data`, `@config.factory`.

Methods:
- `getSettings($uid)` → array `['comment_notify' => …, 'entity_notify' => …]` or `NULL`.
  Anonymous (`uid 0`) returns the defaults.
- `getSetting($uid, $setting)` — one of `'comment_notify'` / `'entity_notify'`; falls back to
  defaults from `comment_notify.settings:enable_default`.
- `getDefaultSettings()` — reads `enable_default.watcher` / `enable_default.entity_author`.
- `saveSettings($uid, $entity_notification = NULL, $comment_notification = NULL)`.
- `deleteSettings($uid)`.

```php
$svc = \Drupal::service('comment_notify.user_settings');
$mode = $svc->getSetting($uid, 'comment_notify'); // default subscription mode for a user
```

## Storage: the `comment_notify` table

Per-comment subscriptions live in a dedicated DB table `comment_notify` (created in
`comment_notify_schema()`), storing the notify mode, the notifier's email, an unsubscribe
`hash`, and whether a notification was already sent. This is separate from the `user.data`
defaults above.

## Constants (defined in `comment_notify.module`)

- `COMMENT_NOTIFY_DISABLED` = 0
- `COMMENT_NOTIFY_ENTITY`   = 1  (all comments)
- `COMMENT_NOTIFY_COMMENT`  = 2  (replies to my comment)

## Hooks the module implements (not hooks it invites)

`comment_notify` provides no `*.api.php`. It reacts via core hooks: `hook_form_comment_form_alter`
and `hook_form_user_form_alter` (checkboxes), `hook_comment_insert/update/publish/delete/load`
(record + send), `hook_mail` (`comment_notify_mail`, keys `comment_notify` / `entity_author`),
`hook_entity_extra_field_info`, and `hook_user_predelete/user_cancel` (cleanup).

## Routes

| Route | Path | Permission |
|---|---|---|
| `comment_notify.settings` | `/admin/config/people/comment_notify` | `administer comment notify` |
| `comment_notify.unsubscribe` | `/admin/config/people/comment_notify/unsubscribe` | `administer comment notify` |
| `comment_notify.disable` | `/comment_notify/disable/{hash}` | `access content` |
