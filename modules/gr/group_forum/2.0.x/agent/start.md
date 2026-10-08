<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Forum (group_forum) — agent index
**Relates core Forum containers/nodes to Group entities and enforces forum access through Group permissions + node grants.**

- **Version:** 2.0.x
- **Core:** ^9.5 || ^10 · **Depends:** forum, group
- **Plugin:** `GroupContentEnabler` `group_forum` (entity `taxonomy_term` bundle `forums`, cardinality 1).
- **Routes:** `group/{group}/forum/add` & `/create` (route provider), both require group permission `create group_forum content`.
- **Permission:** `access group_forum overview` (overview report only).
- **Access hooks (`group_forum.module`):** `taxonomy_term_access` + `node_access` (check `view/update/delete group_forum` group perms, walk term parents), `query_*_alter` (hide forbidden tids), `node_grants` / `node_access_records` (realm `group_forum`, bypass realm `group_forum_bypass` for `bypass group access`).
- **Security:** access is enforced via `$group->hasPermission()` and Drupal node-access grants; add/create routes are group-permission-gated; anonymous/outsider access derived from group-type roles via the role synchroniser. No overbroad/anonymous mutating routes observed — no security findings.

See [configure/access.md](configure/access.md).