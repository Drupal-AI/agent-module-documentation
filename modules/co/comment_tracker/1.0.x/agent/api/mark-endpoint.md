<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity, manager service & mark endpoint

## Storage entity

`src/Entity/CommentTracker.php` — `@ContentEntityType(id = "comment_tracker")`, base table
`comment_tracker`, `fieldable = FALSE`, entity keys `id` + `uuid`, only a `views_data` handler
(`EntityViewsData`). Implements `CommentTrackerInterface` (extends `ContentEntityInterface` +
`EntityChangedInterface`). Base fields:

| field | type | notes |
|-------|------|-------|
| `comment_id` | entity_reference → `comment` | required |
| `viewer_uid` | entity_reference → `user` | required |
| `created` | created | set to request time when the read is recorded |
| `changed` | changed | from `EntityChangedTrait` |

One row = "user `viewer_uid` has read comment `comment_id`". There is no access handler, no form,
no bundle. Because the entity type has no `install` hook or explicit schema install, the
`comment_tracker` base table is created by core entity-definition install when the module is enabled.

## Manager service (`comment_tracker.manager`, `CommentTrackerManager`)

Constructor args: `entity_type.manager`, `current_user`, `cache.default`.

- **`getStats(EntityInterface $entity): object`** — returns `{new, read, total}`. Returns zeros for
  anonymous (uid 0). Otherwise checks its per-user cache (see tracking.md), then
  `comment` storage `loadByProperties(['entity_id' => id, 'entity_type' => type])` to load the
  comments on the entity. For each comment: skips the current user's own comments; skips comments
  whose `comment_type` does not have `comment_tracker.enabled`; then counts it as `read` if a
  `comment_tracker` row exists for (uid, cid) else `new`.
- **`isTrackingEnabled(EntityInterface $entity): bool`** — node-only opt-in check (see tracking.md).
- **`isNewComment(Comment $comment): bool`** — FALSE for anonymous and for the user's own comment;
  otherwise TRUE when no `comment_tracker` row exists for (uid, cid). (Contains leftover debug
  local `$test` that is computed but unused.)
- **`markCommentRead(Comment $comment): void`** — no-op for anonymous; logs a debug message; no-op
  if the comment is the user's own; then `loadByProperties(['viewer_uid'=>uid,'comment_id'=>cid])`
  and, if none exists, `create()` + `save()` a `comment_tracker` row with the current timestamp,
  then invalidates cache tags. Duplicate-safe (won't insert a second row for the same pair).

## Mark route & controller

`comment_tracker.routing.yml`:

```
comment_tracker.mark:
  path: '/comment-tracker/mark'
  defaults:
    _controller: '\Drupal\comment_tracker\Controller\CommentTrackerController::markRead'
  requirements:
    _permission: 'access content'
```

`CommentTrackerController::markRead(Request)` (`ControllerBase`):
1. `$uid = (int) currentUser()->id();` — if 0, returns `JsonResponse(['status'=>'denied'], 403)`
   (so anonymous cannot record reads even though `access content` may be granted to anonymous).
2. `$comment_id = (int) $request->query->get('comment_id')` — if falsy, `400` `missing comment_id`.
3. Load the comment by id — if not found, `421` `not found`.
4. `comment_tracker.manager->markCommentRead($comment)`, then `JsonResponse(['status'=>'ok'])` (200).

The route uses `GET` (the JS calls it with `method:'GET'`). It records only a private read-state
row for the calling user and returns a fixed JSON status string, not comment content.

## End-to-end flow

1. A tracked comment is rendered → `hook_preprocess_comment` attaches the JS and a `markUrl`
   (`Url::fromRoute('comment_tracker.mark', [], ['query'=>['comment_id'=>cid]])`).
2. The reader scrolls the comment into view; after 5s the JS `fetch`es `markUrl`.
3. `markRead` → `markCommentRead()` inserts a `comment_tracker` row and invalidates caches.
4. On the next render, `isNewComment()` returns FALSE and `getStats()` counts the comment as read.
