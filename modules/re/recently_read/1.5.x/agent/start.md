<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recently Read — agent index

Records per-user (or per-session for anonymous) view history of enabled entity types and
exposes it through Views. Tracking is automatic on full-view render; you choose which entity
types/bundles to track and how history is pruned.

- **Enable tracking, pruning options, the config entity, and the shipped view/relationship** →
  [configure/tracking.md](configure/tracking.md)
- **`recently_read` service API, entities, and the Views plugins** →
  [api/service.md](api/service.md)

Key facts:
- Two config surfaces: the `recently_read_type` collection at
  `/admin/structure/recently-read` (route `entity.recently_read_type.collection`, the
  `configure` route) enables entity types/bundles; the settings form at
  `/admin/config/system/recently-read/config` (route `recently_read.settings_basic`,
  permission `access configuration pages`) sets pruning.
- Recording happens in `hook_entity_view()` → `RecentlyReadService::insertEntity()` for
  `view_mode === 'full'`, only for entity types with a matching `recently_read_type`.
- Data lives in the `recently_read` content entity (fields `user_id`, `session_id`, `type`,
  `entity_id`, `created`). Anonymous history keys on `session_id`.
- Ships config for `node` and a view `recently_read_content` using the Views relationship
  `recently_read_relationship` + boolean filter `recently_read_user_filter`.
- Depends on `views`. No permissions of its own; provides config schema.
