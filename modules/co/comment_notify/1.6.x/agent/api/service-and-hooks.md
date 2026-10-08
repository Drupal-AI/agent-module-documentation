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
`comment_notify_schema()`), keyed by `cid`, storing the notify mode (`notify`), an
unsubscribe hash (`notify_hash`, indexed), and whether a notification was already sent
(`notified`). This is separate from the `user.data` defaults above. On install, existing
comments are seeded with a salted `notify_hash` and `notify = 0`.

## Constants (defined in `comment_notify.module`)

- `COMMENT_NOTIFY_DISABLED` = 0
- `COMMENT_NOTIFY_ENTITY`   = 1  (all comments)
- `COMMENT_NOTIFY_COMMENT`  = 2  (replies to my comment)

## Sending behaviour (`_comment_notify_mailalert`)

Triggered from `hook_comment_insert/update/publish` for published comments. It:
- sends at most one mail per address (`$sent_to` de-duplication, case-insensitive);
- optionally mails the commented entity's author (`entity_author` template) when they are
  subscribed (or subscribed by default) and are not the current commenter;
- mails each subscribed commenter ("watcher") whose subscription matches the thread;
- only mails a recipient who can still `view` the commented entity (`$entity->access('view', $recipient)`);
- for a registered subscriber, reads the current account email; **skips** a registered
  subscriber whose account has no email address;
- marks the comment as notified (`notified = 1`) so later edits don't re-notify.

## Hooks the module implements (not hooks it invites)

`comment_notify` provides no `*.api.php`. It reacts via core hooks: `hook_form_comment_form_alter`
and `hook_form_user_form_alter` (checkboxes), `hook_comment_insert/update/publish/delete/load`
(record + send), `hook_mail` (`comment_notify_mail`; params include `subject`, `body`, `cid`),
`hook_entity_extra_field_info`, `hook_token_info`/`hook_tokens` (`[comment:unsubscribe-url]`
and the `comment-subscribed` token type), and `hook_user_predelete`/`hook_user_cancel`
(cleanup). `hook_help` is implemented as an OOP hook in
`Drupal\comment_notify\Hook\CommentNotifyHooks` (`#[Hook('help')]`), with a `#[LegacyHook]`
wrapper in `comment_notify.module`.

## Routes

| Route | Path | Permission |
|---|---|---|
| `comment_notify.settings` | `/admin/config/people/comment_notify` | `administer comment notify` |
| `comment_notify.unsubscribe` | `/admin/config/people/comment_notify/unsubscribe` | `administer comment notify` |
| `comment_notify.disable` | `/comment_notify/disable/{hash}` | `access content` |
