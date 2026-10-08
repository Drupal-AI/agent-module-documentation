<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Activity Tracker (the contrib continuation of core's former `tracker` module) displays a site's most recently added or updated content and lets you follow the recent content of any individual user, backed by a denormalized index kept up to date on node/comment changes.

---

The module maintains two denormalized tables, `tracker_node` (last-changed timestamp + published flag per node) and `tracker_user` (per node + user who authored or commented), updated by entity hooks (`tracker_node_insert/update/predelete`, `tracker_comment_insert/update/delete`) via `_tracker_add`/`_tracker_remove`. On install it seeds `tracker.index_nid` state to the highest node id and `hook_cron` back-fills existing nodes in batches of `cron_index_limit` (default 1000, the only config value, schema `tracker.settings`). `TrackerController::buildContent` renders three pages: `/activity` (all recent content, from the replica DB), `/activity/{user}` ("my recent content", restricted to the logged-in user), and `/user/{user}/activity` (the **Activity** tab on a user profile, gated by `user.view`). All are permissioned with core `access content`, query only `published = 1`, add the `node_access` tag so grants are respected, page 25 rows, and enrich each row with comment statistics; results are cached with node/owner cache tags and the `user.node_grants:view` context. When `history` is enabled, an attached library marks read/unread state for authenticated users. `tracker_views_data()` exposes the two tables to Views (fields/filters/sorts on nid, uid, published, changed) and `tracker_views_data_alter()` adds a `uid_touch_tracker` argument/filter ("user posted or commented") on `node_field_data`, implemented by the module's `tracker_user_uid` Views argument/filter plugins. It also ships Drupal 7 → 9+ migrations for tracker settings and index tables. There is no admin UI or module permission.

---

- Show visitors a "Recent content" page of the newest and recently updated nodes.
- Let a logged-in user see their own recent content via the "My recent content" tab.
- Add an "Activity" tab to user profiles listing content that user posted or commented on.
- Follow a specific author's contributions across the site.
- Build a Views listing of recently touched nodes using the Tracker tables.
- Filter a View to nodes a given user posted or commented on (`uid_touch_tracker`).
- Sort content by last activity (edit or newest comment), not just node changed time.
- Respect node access grants so private content stays hidden in tracker lists.
- Show only published content in activity listings.
- Include comment activity in a node's "last updated" time.
- Display per-node comment counts and last-comment timestamps in the list.
- Read the tracker index from a database replica to offload the primary DB.
- Batch-index a large existing site's back catalogue via cron after install.
- Tune indexing throughput with the `cron_index_limit` setting.
- Provide an activity feed page cached with proper node and grant cache metadata.
- Integrate read/unread markers when the History module is enabled.
- Migrate Drupal 7 tracker data and settings into Drupal 9/10/11.
- Give editors a quick overview of what changed recently for moderation.
- Surface newly commented threads to keep discussions active.
- Keep the tracker tables automatically consistent as nodes and comments change or are deleted.
- Expose Tracker - User and Tracker (node) groups of fields to the Views UI.
- Restore the recent-content experience removed from Drupal core as a contrib module.
