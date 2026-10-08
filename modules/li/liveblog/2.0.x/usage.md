<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Liveblog turns a Drupal node into a live-blog: a `liveblog` node type owns a stream of lightweight `liveblog_post` content entities that are published and pushed to readers in real time (via pluggable notification channels such as Pusher).

---

The node acts as the container; editors add `liveblog_post` entities (title, body, optional highlights taxonomy, geo via simple_gmap) which appear at the top of the stream. New posts reach readers through a `LiveblogNotificationChannel` plugin — the bundled `liveblog_pusher` submodule pushes over Pusher's socket service — while a JSON polling endpoint provides the fallback/initial load. Posts are created and edited through AJAX-driven forms: `LiveblogController::getFormAsJson()` returns the edit form as JSON, and a REST resource plus a `LiveblogPostForm` handle create/update. Editorial access is permission-based: `add`/`edit`/`delete liveblog_post entity` and `administer liveblog settings`.

Two behaviours are worth knowing when reasoning about exposure. The read endpoint `entity.liveblog_post.list` at `/liveblog/{node}/posts` is gated by `_permission: 'access content'` (effectively anonymous) and returns a JSON stream of rendered posts — this is by design for public live blogs. It only ever returns **published** posts: the query hard-codes `->condition('status', 1)` and runs with `accessCheck()`, and it 404s if the node bundle isn't `liveblog`. However it does not verify the *parent node's* own view access/published state before listing that node's published posts, so published posts attached to an unpublished or access-restricted liveblog node could still be enumerated via this endpoint — a low-severity information-exposure edge case. The entity access handler returns `AccessResult::allowed()` for the `view` operation unconditionally (posts are meant to be shown on the public node page), while create/update/delete remain permission-gated, so there is no unauthenticated write path. Setup: enable the module (and `liveblog_pusher` if using Pusher), configure the notification channel and API keys at the settings page, create a Liveblog node and start posting.

---

- Create a live-blog as a `liveblog` node
- Add streamed `liveblog_post` entries to a live blog
- Push new posts to readers in real time via Pusher
- Fall back to polling the JSON post-list endpoint when no push channel is set
- Poll `/liveblog/{node}/posts` for the published post stream as JSON
- Page through the stream using the `created` cursor and `items_per_page`
- Sort the stream ascending or descending by creation time
- Tag posts with a highlights taxonomy term
- Attach a location to a post via simple_gmap
- Edit a post through the AJAX JSON edit form
- Expose posts over core REST for headless posting
- Gate post create/edit/delete behind the liveblog_post permissions
- Configure the notification channel and API keys on the settings page
- Set default posts-load-limit and initial-post-count fields on a live blog
- Add a custom `@LiveblogNotificationChannel` plugin for another websocket provider
- Understand that the public list endpoint returns only published posts (`status=1`, access-checked)
- Note that the list endpoint does not re-check the parent node's own access before listing its posts
