<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Forum Access participates in node access

All access enforcement is in `forum_access.module` plus `includes/forum_access.common.inc`.
Two layers work together: **grant records** (drive listing queries via the `node_access`
table) and **dynamic hooks** (drive direct entity/route checks). Realm is `forum_access`.

## Grant records (listings)

`forum_access_node_grants($account, $op)` — returns `['forum_access' => [gid, …]]`, one
integer `gid` per role the account holds, looked up in
`forum_access.settings:forum_access_roles_gids`. "Roles are used as ACLs, so rids translate
directly to gids."

`forum_access_node_access_records($node)` — for published `forum`-bundle nodes only: resolves
the forum `tid` (`forum_access_get_tid()`), reads the `{forum_access}` rows for that tid
(`forum_access_get_grants_by_tid()`), and emits one grant record per role row:
`{realm: 'forum_access', gid: roles_gids[rid], grant_view, grant_update, grant_delete,
priority}`. Roles that have `bypass node access` ("seers") are **skipped** — they access
everything anyway, so emitting grants for them would be redundant. Unpublished nodes and
non-forum nodes return `[]` (unpublished nodes stay protected by core's publish-status check).

Because these two hooks are keyed on the same `roles_gids` mapping, a user can view a forum
topic exactly when one of their roles has `grant_view = 1` in `{forum_access}` for that
forum's tid (grants OR-combine with other node-access modules).

Grant records are (re)written whenever a forum node is saved: `forum_access_node_insert()` /
`forum_access_node_update()` attach the forum's moderator ACL to the node
(`acl_node_add_acl($nid, $acl_id, 1, 1, 1)`) and call
`$handler->acquireGrants($node)` + `node.grant_storage->write()`. Moving a topic to a
different forum clears the old ACL and re-writes. Bulk changes from the admin form run
`node_access_rebuild()` or a batch (`_forum_access_update_batch_operation()`).

## Dynamic checks (direct access)

- `forum_access_node_access($node, $op, $account)` — forum nodes only. Forbids up front if the
  account has no **view** access to the forum; then allows `view` (published, or own +
  `view own unpublished content`), `update` (`edit any|own forum content`), `delete`
  (`delete any|own forum content`) when the forum's view grant also holds. Otherwise neutral.
- `forum_access_node_create_access()` — on `forum.page` / `node.add`, allows creating a topic
  only when `forum_access_access('create', $tid)` passes.
- `forum_access_comment_access()` — mirrors the node rules for comments on forum topics
  (view/update/delete/approve), keyed on the parent topic's forum tid; denies by default.
- `forum_access_taxonomy_term_access()` — hides `forums` terms the user cannot view.
- Route access: `RouteSubscriber` swaps `_custom_access` on `forum.index`, `forum.page`,
  `comment.reply` to `Drupal\forum_access\ForumAccess\Access::{forumIndex,forumPage,commentReply}`.

## Query alters

- `forum_access_query_taxonomy_term_access_alter()` — restricts taxonomy-term queries to
  forums the account (by role or moderator ACL) may view; users with `bypass node access` on
  the forum/vocabulary overview pages are left unrestricted so they can administer structure.
- `forum_access_query_comment_filter_alter()` — lets users with update/delete access (i.e.
  moderators/editors) see unpublished comments in a forum thread.

## Field formatter & form/link alters

- Field formatter `comment_forum` (`src/Plugin/Field/FieldFormatter/CommentForumFormatter.php`,
  extends core `CommentDefaultFormatter`) renders the forum comment field but suppresses the
  comment list / reply form for users without the relevant forum grant.
- `forum_access_node_view_alter()` / `forum_access_node_links_alter()` /
  `forum_access_comment_links_alter()` strip the reply form and comment links when the user
  lacks `create` on the forum.
- `forum_access_form_node_form_alter()` limits the topic's forum-select options to forums the
  author may post to (or moderate), and unlocks sticky/revision/comment settings for moderators.

## Config/role sync

`forum_access_user_role_insert()` appends a new gid for a new role;
`forum_access_user_role_delete()` removes the role's `{forum_access}` and `node_access` rows
and its `roles_gids` entry. `forum_access_taxonomy_term_delete()` removes `{forum_access}`
rows when a forum term is deleted.
