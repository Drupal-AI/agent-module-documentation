<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pages, index tables, hooks & Views

Sources: `tracker.routing.yml`, `src/Controller/TrackerController.php`, `tracker.module`,
`tracker.install`, `tracker.views.inc`, `src/Plugin/views/{argument,filter}/UserUid.php`,
`src/Plugin/Menu/UserTrackerTab.php`, `migrations/*`.

## Routes / pages (all `_permission: access content`)

| Route | Path | Access extra | Shows |
|---|---|---|---|
| `tracker.page` | `/activity` | — | All recent published content (from DB **replica**). |
| `tracker.users_recent_content` | `/activity/{user}` | `_custom_access` `checkAccess` (authenticated **and** viewing self) | The logged-in user's recent content. |
| `tracker.user_tab` | `/user/{user}/activity` | `_entity_access: user.view` | That user's recent content (profile **Activity** tab). |

`TrackerController::buildContent()` selects from `tracker_user` (when scoped to a user) or
`tracker_node`, adds the **`node_access`** query tag, filters `published = 1`, orders by `changed`
DESC, pages 25, then loads nodes and enriches rows with `comment.statistics`. Output is a themed table
(Type / Title / Author / Comments / Last updated) with a pager; cached with node + owner cache tags,
node list cache tags, and the `user.node_grants:view` context. If `history` is enabled, authenticated
users get the `tracker/history` library (read/unread markers).

## Index tables (`hook_schema`)

- `tracker_node(nid PK, published tinyint, changed)` — one row per node, last change/comment time.
- `tracker_user(nid, uid, published, changed)` — one row per (node, user who authored or commented).

## Indexing hooks (`tracker.module`)

- `tracker_node_insert/update` → `_tracker_add($nid, $ownerId, $changedTime)`.
- `tracker_node_predelete` → delete rows for the node.
- `tracker_comment_insert/update/delete` → `_tracker_add`/`_tracker_remove` for the commented node.
- `_tracker_add()` merges node- and user-level rows, taking `max(node.changed, $changed)`.
- `_tracker_remove()` drops a user's subscription unless they authored the node or still have a
  published comment on it, then recalculates the node's changed timestamp
  (`_tracker_calculate_changed()` = max of node changed and latest comment).
- `hook_cron()` back-fills existing nodes in batches of `cron_index_limit`, driven by state
  `tracker.index_nid` (seeded at install to the max node id; set to 0 when done).

## Views integration (`tracker.views.inc`)

- `tracker_views_data()` exposes `tracker_node` (group "Tracker") and `tracker_user` (group
  "Tracker - User"), both INNER-joined to `node_field_data` (and `tracker_user` to `user_field_data`),
  with field/filter/sort handlers on `nid`, `uid`, `published`, `changed`.
- `tracker_views_data_alter()` adds `node_field_data.uid_touch_tracker` — an argument **and** filter
  "User posted or commented" (handler id `tracker_user_uid`, classes in `src/Plugin/views/`), letting a
  View list nodes a given user authored or commented on.

## Migrations

`migrations/d7_tracker_node.yml`, `d7_tracker_user.yml`, `d7_tracker_settings.yml` (+ state file and
source plugins `TrackerNode`/`TrackerUser`) migrate Drupal 7 tracker index + settings to D9/10/11.
