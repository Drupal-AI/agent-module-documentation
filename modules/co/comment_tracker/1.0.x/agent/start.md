<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment tracker (comment_tracker) — agent index

Per-user **read/unread comment tracking** on top of Drupal core comments. For each
(user, comment) pair the first time a signed-in user actually *sees* a comment, the module
stores a `comment_tracker` record; from that state it exposes **new/read/total** counts to
node templates and an **`is_new_comment`** flag to comment templates, so a theme can render
"new comment" indicators. Client JS marks a comment read once it has been ~50% visible in the
viewport for 5 seconds by pinging a mark endpoint. Package `Other`. Core `^10 || ^11`.
License GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`).

This is a read-state tracker (like "new since last visit"), **not** a hit-counter / view-count
analytics tool.

## Dependencies

- Declares **no** `dependencies:` in `.info.yml` and only `drupal/core` in `composer.json`, but
  it is functionally built on core **Comment** (uses the `comment` and `comment_type` entities and
  a `comment` field on nodes) and on **Node** (`isTrackingEnabled()` only returns TRUE for nodes).
- JS libraries: `core/drupal`, `core/drupalSettings`, `core/once` (`comment_tracker.libraries.yml`).
- No third-party PHP/JS libraries. No `key` dependency, no external API.

## What it provides (from source)

- **Content entity** `comment_tracker` (`src/Entity/CommentTracker.php`) — base table
  `comment_tracker`, `fieldable = FALSE`, non-bundled. Base fields: `comment_id`
  (entity_reference → comment, required), `viewer_uid` (entity_reference → user, required),
  `created`, `changed`. One row per (user, comment) read. Has `views_data` handler; no forms,
  no access handler, no admin UI.
- **Service** `comment_tracker.manager` (`CommentTrackerManager`, args `entity_type.manager`,
  `current_user`, `cache.default`) — `getStats()`, `isTrackingEnabled()`, `isNewComment()`,
  `markCommentRead()`. See [api/mark-endpoint.md](api/mark-endpoint.md).
- **Route** `comment_tracker.mark` → `GET /comment-tracker/mark?comment_id=N`,
  controller `CommentTrackerController::markRead`, requirement `_permission: 'access content'`.
  Returns a small JSON status. See [api/mark-endpoint.md](api/mark-endpoint.md).
- **Per-comment-type opt-in**: `hook_form_comment_type_edit_form_alter` adds an "Enable Comment
  Tracker" checkbox stored as the comment-type third-party setting
  `comment_tracker.enabled`. Tracking only runs for comment types where this is on.
- **Preprocess hooks** (`comment_tracker.module`): `hook_preprocess_node` injects
  `comment_stats` (new/read/total); `hook_preprocess_comment` injects `is_new_comment`, attaches
  the JS library and per-comment `drupalSettings`. `hook_comment_insert` invalidates cache tags.
- **JS behavior** `comment_tracker/comment_tracker` (`js/comment_tracker.js`) — IntersectionObserver
  that fires the mark endpoint after a comment is 50% visible for 5s, then strips indicator classes.
- **No** permissions file, **no** config schema, **no** config/settings form, **no** install/update
  hooks, **no** templates, **no** Drush commands.

## Solution docs

- **Enabling tracking, Twig variables, CSS classes, JS behavior, caching** →
  [config/tracking.md](config/tracking.md)
- **Entity, manager service, mark route/controller, request flow** →
  [api/mark-endpoint.md](api/mark-endpoint.md)
