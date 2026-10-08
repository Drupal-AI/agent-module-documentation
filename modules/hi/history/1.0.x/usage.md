<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
History records which nodes each authenticated user has read and when, powering the "New"/"Updated" markers, the "new comments" counter, and Views filters for unread content. It is core's `history` module, moved out of core and maintained as contrib for Drupal >11.3.

---

Its entire storage is one table, `history` (`uid`, `nid`, `timestamp`, primary key `uid+nid`, index on `nid`) plus a constant, `HISTORY_READ_LIMIT` — request time minus 30 days. Anything older than that is treated as read, and `hook_cron()` deletes rows below the limit, so the table stays bounded. Reads and writes go through three procedural helpers kept for backwards compatibility — `history_read($nid)`, `history_read_multiple($nids)` (statically cached) and `history_write($nid, $account = NULL)` — while the newer `Drupal\history\HistoryManager` service provides `getCountNewComments($entity, $field_name, $timestamp)`. Marking happens client-side: on a full node view the module attaches the `history/mark-as-read` library and a `drupalSettings.history.nodesToMarkAsRead` entry, and JavaScript posts to `/history/{node}/read`; two more endpoints, `/history/get_node_read_timestamps` and `/history/render_new_comments_node_links`, feed the comment "new" indicator and the "x new comments" link. Comment views get `history/drupal.comment-new-indicator` plus a `#lazy_builder` placeholder carrying the last-read timestamp, so pages stay cacheable. For site builders the value is in Views: `hook_views_data()` joins `history` to `node_field_data` on `nid` with an implicit `uid = ***CURRENT_USER***` condition and exposes `history_user_timestamp` as both a field ("Has new content" marker) and a filter ("Show only content that is new or updated"), and `hook_views_data_alter()` adds a `node_new_comments` field. A token, `[<entity>:comment-count-new]`, is registered for every entity type that has comment fields. There is no configuration, no permission and no admin UI; the module also cleans up history rows when a node is deleted, a user is deleted, or an account is cancelled with `user_cancel_reassign`.

---

- Show the core "New" / "Updated" markers next to node titles in a listing.
- Add an "Unread content" view using the `history_user_timestamp` filter.
- Show a "Has new content" marker column in a custom Views listing of articles.
- Display an "x new comments" link on teasers with the `node_new_comments` Views field.
- Give forum topics working new/updated indicators.
- Highlight comments posted since a user's last visit with the comment "new" indicator.
- Build a personalised dashboard of nodes the current user has not read.
- Print the number of unread comments in an email with the `[node:comment-count-new]` token.
- Track read state per user for a documentation or knowledge-base section.
- Mark a node as read programmatically after an import or a migration.
- Reset a user's read state by deleting their rows from the `history` table.
- Query "who has read this node" for a lightweight readership report.
- Keep the read-tracking table bounded automatically through the 30-day cron cleanup.
- Restore the removed core `history` module on a Drupal >11.3 site so existing views keep working.
- Provide read timestamps to a decoupled front end through `/history/get_node_read_timestamps`.
- Mark a node as read from custom JavaScript by posting to `/history/{node}/read`.
- Count new comments on any entity type with `HistoryManager::getCountNewComments()`.
- Limit a "new comments" count to a single comment field by passing `$field_name`.
- Compute new-comment counts from an arbitrary timestamp instead of the last-read time.
- Attach the `history/api` library to add read-timestamp handling to a custom component.
- Ensure history rows are removed when a node is deleted, so ids are never reused stale.
- Purge a departing user's reading history automatically on account cancellation.
- Keep node pages cacheable while still showing per-user markers, thanks to the lazy-builder placeholder.
- Diagnose why a marker is missing by inspecting the `history` row for that uid/nid.
