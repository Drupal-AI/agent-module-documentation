<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling tracking, Twig variables, CSS & JS

## Enable per comment type

There is no settings page. Tracking is opted-in **per comment type**. `comment_tracker.module`
adds a details section with an **"Enable Comment Tracker"** checkbox to the comment-type edit form
(`hook_form_comment_type_edit_form_alter`, `/admin/structure/comment/manage/{type}`). Its own
submit handler (`comment_tracker_comment_type_form_submit`) saves the value as the comment-type
third-party setting `comment_tracker.enabled` (default FALSE). No config schema ships for this
setting — it is stored on the `comment.type.*` config entity as a third-party setting.

`CommentTrackerManager::isTrackingEnabled($entity)` decides whether a **node** is tracked:
returns FALSE for any non-node entity; otherwise iterates the node's field definitions, finds
`comment`-type fields, loads each field's configured `comment_type`, and returns TRUE as soon as
one of them has `comment_tracker.enabled` = TRUE. So enabling tracking on a comment type turns it
on for every node bundle that uses a comment field bound to that comment type.

## Twig variables

### Nodes (`hook_preprocess_node`)

When `isTrackingEnabled($node)` is TRUE, `comment_stats` is added to the node template, from
`CommentTrackerManager::getStats($node)`:

| var | meaning |
|-----|---------|
| `comment_stats.new` | count of comments on the node the current user has **not** read |
| `comment_stats.read` | count the user **has** read |
| `comment_stats.total` | `new + read` |

Comments authored by the current user are excluded from all three counts. Anonymous users
(uid 0) always get `{new:0, read:0, total:0}`. (README also mentions `comment_stats.unread` as an
alias of `new`; the source `getStats()` object does **not** set an `unread` key.)

### Comments (`hook_preprocess_comment`)

When the commented entity is tracked, the comment template gets
`is_new_comment` (bool) from `CommentTrackerManager::isNewComment($comment)` — TRUE when the
signed-in user has no tracker row for that comment and is not its author (FALSE for anonymous and
for the user's own comments). The hook also attaches the JS library and per-comment
`drupalSettings.comment_tracker.comments[cid] = { id, markUrl }`.

## CSS hooks (theme-supplied)

The module ships **no** CSS and **no** Twig templates. The README documents two class names the
theme is expected to output so the JS can find and remove them once a comment is read:

- `comment-tracker-indicator__new_comment` — a per-comment "new" badge.
- `comment-tracker__comment_stats` — a node-level unread counter.

Example (theme's `comment.html.twig` / `node.html.twig`):

```twig
{% if is_new_comment %}
  <span class="comment-tracker-indicator__new_comment">New</span>
{% endif %}

{% if comment_stats.new > 0 %}
  <div class="comment-tracker__comment_stats">{{ comment_stats.new }}</div>
{% endif %}
```

## JS behavior (`js/comment_tracker.js`)

`Drupal.behaviors.commentTracker` reads `drupalSettings.comment_tracker.comments`, and for each
`#comment-{id}` element (deduped with `once`) attaches an `IntersectionObserver` (threshold 0.5).
When the comment becomes ≥50% visible it waits **5000 ms**, then `fetch(markUrl, {method:'GET',
credentials:'same-origin'})`; on success it adds the `comment-read` class, removes the
`.comment-tracker-indicator__new_comment` badge, and removes the node's
`.comment-tracker__comment_stats` element. The observer unobserves after the first trigger.

Note: the JS also references `c.authorUid` / `drupalSettings.comment_tracker.current_uid` to skip
the viewer's own comments, but the PHP `hook_preprocess_comment` does **not** populate those keys,
so that client-side skip is currently inert — the server side still refuses to record a user's own
comments (see [api/mark-endpoint.md](api/mark-endpoint.md)).

## Caching

- `getStats()` caches its result object in `cache.default` under
  `comment_tracker:{entity-uuid}:user:{uid}` (CACHE_PERMANENT) with tags
  `entity:{type}:{id}` and `user:{uid}`.
- `hook_preprocess_node` adds cache context `user` and tags `node:{nid}` and
  `comment_tracker:viewer:{uid}`. `hook_preprocess_comment` adds context `user` and tags
  `comment:{cid}` and `comment_tracker:viewer:{uid}`.
- `hook_comment_insert` invalidates `entity:{type}:{id}` and
  `comment_tracker:entity:{type}:{id}` when a new comment is added.
- `markCommentRead()` invalidates `entity:{type}:{id}`, `user:{uid}`,
  `comment_tracker:viewer:{uid}` and `comment:{cid}` after recording a read.
