# API — the logger service and its tables

## Service

- **id:** `notifications_widget.logger`
- **class:** `Drupal\notifications_widget\Services\NotificationsWidgetService`
- **interface:** `Drupal\notifications_widget\Services\NotificationsWidgetServiceInterface`

```php
public function logNotification(
  array $message,          // ['id' => ..., 'bundle' => ..., 'content' => ..., 'content_link' => ...]
  string $userAction,      // 'create' | 'update' | 'delete'
  object $entity,          // the entity that triggered it (used for token replacement)
  int $recipient_uid = NULL,
  int $operator_uid  = NULL
): void;
```

Example (any module can call it):

```php
$logger = \Drupal::service('notifications_widget.logger');
$logger->logNotification([
  'id'           => $node->id(),
  'bundle'       => $node->bundle(),
  'content'      => 'New article [node:title] by [user:name]',
  'content_link' => '[entity:url]',
], 'create', $node);
```

### `$message` array keys

| Key | Written to `notifications` column | Notes |
|---|---|---|
| `id` | `entity_id` | Source entity id. |
| `bundle` | `bundle` | Source bundle machine name. |
| `content` | (into `message`) | Template; wrapped in an `<a class="noti-store-msg" …>` and token-replaced. |
| `content_link` | (into the link's `data-link`) | If exactly `[entity:url]` and the entity has a canonical route, resolved to `$entity->toUrl()->toString()`. |

### Behavior

1. If `$entity` is a `ContentEntityInterface` whose type is **not** one of `user`, `node`,
   `taxonomy_term`, `comment`, the call returns early (no row). Other object types pass this guard.
2. **Recipient uid** (`entity_uid` column): the passed `$recipient_uid`; else if the bundle is `user`
   the entity id; else if the entity has `getOwner()` the owner's uid; else `1`.
3. **Operator uid / name** (`uid`, `user_name` columns): the passed `$operator_uid` (name loaded via
   the user storage); else the current user.
4. Skips if `$entity->bundle()` is in the `excluded_entities` config CSV.
5. Builds the anchor markup, replaces tokens (`user` always; plus `node`/`term`/`comment` matching the
   entity), and `merge()`-inserts a row into `notifications` with `status = 0` (unread) and the current
   request time. Failures are caught and logged to the `activity_tracking` channel.

Token data offered: `['user' => current_user]` plus one of `node` / `term` / `comment`.

## Storage tables (`hook_schema`, not entities)

**`notifications`** — the master log (one row per logged event):

| Column | Meaning |
|---|---|
| `id` | Serial PK; also the id used by the block/JS as `notiId`. |
| `entity_id` | Source entity id. |
| `entity_uid` | Recipient uid (see recipient resolution). |
| `action` | `create`/`update`/`delete`. |
| `bundle` | Source bundle. |
| `uid` | Operator uid (who performed the action). |
| `user_name` | Operator display name. |
| `message` | Pre-rendered anchor HTML (tokens already replaced). |
| `status` | Always 0 at insert. |
| `created` | Request timestamp. Indexed. |

**`notifications_actions`** — per-user read/delete markers: `id` (PK), `notification_id`, `uid`,
`status` (`1`=read, `2`=delete), `created`.

**`notifications_clear_all`** — per-user "clear all" watermark: `id` (PK), `notification_id` (the last
notification id at clear time), `uid`, `created`. The block hides everything with id `<=` the user's
latest watermark.

Install messaging: `hook_install` and `hook_page_top` nag admins to save the settings form once.
`hook_update_8101`–`8105` migrate the message column/actions tables from the 8.x-1.x line.
