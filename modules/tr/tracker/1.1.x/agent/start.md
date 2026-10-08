<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity Tracker — agent index

Contrib continuation of Drupal core's former `tracker` module (machine name `tracker`, label
"Activity Tracker"). Shows recently added/updated content and per-user recent content, backed by two
denormalized index tables kept current by node/comment hooks. Depends on `node`, `comment`. No admin
UI (`configure` null), no module permissions (uses core `access content`), no Drush. One config value
+ Views integration.

- **Pages/routes, the `tracker_node`/`tracker_user` tables, indexing hooks, and Views integration** →
  [api/pages.md](api/pages.md)
- **The single `cron_index_limit` setting (config `tracker.settings`)** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Pages: `/activity` (all recent), `/activity/{user}` (my recent, self only), `/user/{user}/activity`
  (profile Activity tab, gated by `user.view`) — all require `access content`, add the `node_access`
  tag, show published-only, 25/page.
- Index tables updated by `tracker_node_*` / `tracker_comment_*` hooks via `_tracker_add`/
  `_tracker_remove`; `hook_cron` back-fills old nodes in batches of `cron_index_limit` using state
  `tracker.index_nid`.
- Views: `tracker_views_data()` exposes both tables; `tracker_views_data_alter()` adds the
  `uid_touch_tracker` "user posted or commented" argument/filter (plugins `tracker_user_uid`).
- Ships D7→D9+ migrations (`migrations/*.yml`, source plugins `TrackerNode`/`TrackerUser`).
