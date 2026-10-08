<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `notify_widget.api` service — sending & managing notifications

Service id **`notify_widget.api`**, class `Drupal\notify_widget\NotifyWidgetApi`
(`src/NotifyWidgetApi.php`). Injected args: `@database`, `@config.factory`, `@current_user`,
`@cache_tags.invalidator`, `@datetime.time`. All notification state lives in one non-entity DB
table, **`notify_widget`** (defined in `notify_widget_schema()` in `notify_widget.install`).

## Table columns (`notify_widget`)

`id` (serial PK), `uid` (int, owner), `source` (varchar 64), `read` (tinyint, 0 = unread),
`notification_type` (varchar 32), `notification_title` (varchar 512), `notification_text`
(text medium), `link` (varchar 2048, nullable), `timestamp` (int). Indexes on `uid`, `source`,
`read`, `timestamp`.

## Sending

```php
\Drupal::service('notify_widget.api')->send(
  string $source,      // free text; convention is the raising module's machine name (currently unused for filtering)
  string $type,        // notification type, e.g. 'warning' / 'alert' / 'add' — drives the popup icon CSS class "{type}-type"
  string $title,       // notification title
  string $text,        // notification body
  int|array $uid = 0,  // recipient user id, or an array of ids; 0 → current user
  string $link = ''    // click-through path/URL, stored verbatim
): void;
```

`send()` builds one `db->insert('notify_widget')` and executes one `->values(...)->execute()` per
recipient (looping the array), always writing `read = 0` and `timestamp = time->getRequestTime()`,
then invalidates cache tag `notify_widget:{uid}` for each recipient via
`clearNotifyWidgetCacheForUser()`.

## Read-state & deletion methods

- `markAsRead(int $id)` / `markAsUnread(int $id)` → private `setNotificationStatus($id, 0|1)`:
  `UPDATE notify_widget SET read = ? WHERE id = ?`. **Keyed by `id` only** — callers are
  responsible for gating ownership (the routes do; see [routes doc](../routes/notifications.md)).
- `markAllAsReadByUserId(int $uid = 0)` (0 → current user): `UPDATE … SET read = 1 WHERE uid = ?`.
- `deleteNotification(int $notificationId)`: `DELETE … WHERE id = ?`.
- `deleteAllNotificationsByUserId(int $uid)`: `DELETE … WHERE uid = ?`.
- `purgeOldNotificationsIfNeeded()`: if config `purge_days_old` > 0, deletes rows with
  `timestamp < (request_time − days·86400)`. Called on each visit to the full notifications page.

## Query / count helpers

- `getNotificationsForUser(int $uid = 0, int $id = 0, bool $includeRead = TRUE, int $readCutoff = 0)`:
  `SELECT * … WHERE uid = ? ORDER BY timestamp DESC` limited to config `max_notifications` (default
  10). `uid = 0` resolves to the current user; a non-zero `$id` adds `AND id = ?`; `$includeRead`
  false adds `AND read = 0`; a non-zero `$readCutoff` builds an OR group (unread, OR read with
  `timestamp > cutoff`). Returns `stdClass[]` DB rows.
- `getNotificationsForUserPaged(int $uid = 0, int $limit = 10, …)`: same filters, extended with
  core `PagerSelectExtender` (`->limit($limit)`); used by the full-page list.
- `getUnreadNotificationsCount(): int`: count of the current user's `read = 0` rows.
- `clearNotifyWidgetCacheForUser($uid = 0)`: invalidates tag `notify_widget:{uid}` (accepts a
  single id or an array; 0 → current user).

All queries use the Drupal DB abstraction with placeholder conditions (no string-concatenated
SQL). `$link` is stored raw and, when rendered in Twig / table cells, is auto-escaped by the theme
layer (see [block doc](../blocks/widget.md)).
