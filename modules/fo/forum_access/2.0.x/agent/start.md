<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forum Access (forum_access) — agent index

Adds per-forum access control to core Forum. For each forum (a taxonomy term in the
`forums` vocabulary) you choose which roles may **View / Post / Edit / Delete**, plus a
per-forum list of moderator **users**. Enforcement rides Drupal's node-access-grants system
(realm `forum_access`) plus dynamic entity-access hooks; moderators are stored with the
**ACL** module.

Dependencies: `acl:acl (>=2.0)` and `forum`. PHP >= 8.1. Core `^10.3 || ^11 || ^12`.
No settings page of its own — administered from the core Forum overview
(`configure: forum.overview`), where each forum/container edit form gains an **Access
control** section. Defines **no permissions of its own** (reuses core's `administer forums`,
`bypass node access`, `edit/delete any|own forum content`, etc.), **no drush**, no plugin
types. Ships one field formatter (`comment_forum`) and a route subscriber. Submodule
`forum_access_migrate` (D7 → D10+ settings migration, experimental).

Solutions:
- **Set which roles view/post/edit/delete a forum, and assign moderators** → [configure/access-control.md](configure/access-control.md)
- **Understand how grants are computed, stored and applied (node access)** → [hooks/node-access.md](hooks/node-access.md)
- **Call the module's access/settings helpers from your own code** → [api/functions.md](api/functions.md)

Key facts:
- **On Drupal 11+ install `drupal/forum` separately.** Forum left core after Drupal 10; the
  composer `suggest` says *"Required in Drupal 11+. Included in Drupal 10 core."*
- Per-role grants live in a custom table `{forum_access}` (columns `tid, rid, grant_view,
  grant_update, grant_delete, grant_create, priority`; PK `(tid, rid)`). Not an entity, not config.
- Config object `forum_access.settings`, key `forum_access_roles_gids` — maps each role
  machine name (`rid`) to a small integer **gid** (node grants need integer gids). Kept in
  sync by `hook_user_role_insert` / `hook_user_role_delete`; seeded in `hook_install`.
- Node-access realm: `forum_access`. Moderator grants use the ACL module with
  `module='forum_access'`, `name='moderate'`, `figure=<tid>`.
- Service `forum_access.route_subscriber` overrides access on `forum.index`, `forum.page`,
  `comment.reply` (custom access → `Drupal\forum_access\ForumAccess\Access`).
- Theme hook `forum_access_table` renders the roles × grants checkbox grid
  (`templates/forum-access-table.html.twig`).
- Grants combine with OR across node-access modules (standard Drupal semantics); after
  changing grants the module rebuilds node access (`node_access_rebuild`) or flags a rebuild.
- Behavior lives mostly in `.module` + `includes/forum_access.{common,admin,acl}.inc`;
  route/formatter classes in `src/`.
