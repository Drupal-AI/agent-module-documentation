<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read tracking API

## Storage

```php
// history.install — hook_schema()
$schema['history'] = [
  'fields' => [
    'uid'       => ['type' => 'int', 'not null' => TRUE, 'default' => 0],
    'nid'       => ['type' => 'int', 'unsigned' => TRUE, 'not null' => TRUE, 'default' => 0],
    'timestamp' => ['type' => 'int', 'size' => 'big', 'not null' => TRUE, 'default' => 0],
  ],
  'primary key' => ['uid', 'nid'],
  'indexes' => ['nid' => ['nid']],
];
```

One row per (user, node); `timestamp` is the Unix time of the last read.
`hook_update_last_removed()` returns `10100` (updates below that lived in core).

```bash
drush sql:query "SELECT uid, nid, timestamp FROM history WHERE nid = 42"
```

## The 30-day window

```php
define('HISTORY_READ_LIMIT', ((int) $_SERVER['REQUEST_TIME']) - 30 * 24 * 60 * 60);
```

- `hook_cron()` runs `DELETE FROM history WHERE timestamp < HISTORY_READ_LIMIT`.
- `HistoryManager::getCountNewComments()` clamps the comparison timestamp to at least
  `HISTORY_READ_LIMIT`, so content older than 30 days is never "new".

## Procedural API (`history.module`)

```php
history_read(int $nid): int
// Last-read timestamp for the current user, or 0.

history_read_multiple(array $nids): array
// [nid => timestamp], 0 when unread. Statically cached per request.

history_write($nid, ?UserInterface $account = NULL): void
// MERGE into {history} with the request time. No-op for anonymous users.
// Also primes the history_read_multiple() static cache.
```

These are plain functions (still procedural in 1.0.x), so call them directly:

```bash
drush php:eval 'history_write(42, \Drupal\user\Entity\User::load(1)); print history_read(42);'
```

## `HistoryManager` service

Service id is the class name (`history.services.yml` declares
`Drupal\history\HistoryManager` with `autowire: true`):

```php
$manager = \Drupal::service(\Drupal\history\HistoryManager::class);
$new = $manager->getCountNewComments($node);                 // int|FALSE
$new = $manager->getCountNewComments($node, 'comment');      // limit to one comment field
$new = $manager->getCountNewComments($node, NULL, $since);   // from an explicit timestamp
```

Returns **FALSE** when the current user is anonymous or the `comment` module is not
installed. For nodes the baseline is `history_read($nid)`; for other entity types it looks
for a `{entity_type}_last_viewed()` function and otherwise falls back to `COMMENT_NEW_LIMIT`.
It counts published comments created after that timestamp, with `accessCheck(TRUE)`.

`history.comment_link_builder` decorates core's `comment.link_builder`
(`decoration_on_invalid: ignore`, so it is inert without the comment module) to add the
"x new comments" link.

## Routes (all JSON, all deny anonymous)

| Route | Path | Method/params | Returns |
|---|---|---|---|
| `history.get_last_node_view` | `/history/get_node_read_timestamps` | POST `node_ids[]`; `_permission: access content` | `{nid: timestamp}` |
| `history.read_node` | `/history/{node}/read` | `{node}` numeric; `_entity_access: node.view` | new timestamp (int); writes the row |
| `history.new_comments_node_links` | `/history/render_new_comments_node_links` | POST `node_ids[]` + `field_name`; `_permission: access content` | `{nid: {new_comment_count, first_new_comment_link}}`, max 100 nodes |

## Libraries (`history.libraries.yml`)

| Library | JS | Purpose |
|---|---|---|
| `history/api` | `js/history.js` | Client-side read-timestamp store + AJAX |
| `history/mark-as-read` | `js/mark-as-read.js` | POSTs to `/history/{node}/read` on window load |
| `history/drupal.comment-new-indicator` | `js/comment-new-indicator.js` | "New" flag on individual comments |
| `history/drupal.node-new-comments-link` | `js/node-new-comments-link.js` | "x new comments" teaser link |

## Hook implementations (`src/Hook/HistoryHooks.php`, attribute-based)

| Hook | Effect |
|---|---|
| `hook_cron` | Deletes rows older than `HISTORY_READ_LIMIT` |
| `hook_ENTITY_TYPE_view_alter` (node) | Adds `data-history-node-id` when comment is installed; on the **full** view mode attaches `history/mark-as-read` + `drupalSettings.history.nodesToMarkAsRead[nid]` and the `user.roles:authenticated` cache context. Skips new/preview nodes |
| `hook_ENTITY_TYPE_delete` (node) | `DELETE FROM history WHERE nid = …` |
| `hook_ENTITY_TYPE_delete` (user) | `DELETE FROM history WHERE uid = …` |
| `hook_user_cancel` | Same, for the `user_cancel_reassign` method |
| `hook_ENTITY_TYPE_view` (comment) | Attaches `history/drupal.comment-new-indicator` and a `#lazy_builder` placeholder (`HistoryRenderCallback::lazyBuilder`) carrying the commented node's last-read timestamp |
| `hook_help` | Help text only |

`Drupal\history\HistoryRenderCallback::lazyBuilder($node_id)` returns a render array whose
only content is
`#attached.drupalSettings.history.lastReadTimestamps[$node_id] = history_read($node_id)`.
Using it as a placeholder is what keeps node/comment renders cacheable per-role rather than
per-user.

`history.services.yml` also sets `parameters.history.skip_procedural_hook_scan: true` — the
procedural functions in `history.module` are helpers, not hook implementations.
