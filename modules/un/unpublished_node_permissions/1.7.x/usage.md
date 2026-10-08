<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unpublished Node Permissions adds a granular, per-content-type "view unpublished content" permission so you can let specific roles see unpublished nodes of some types (e.g. Articles) without giving them core's blanket "view any unpublished content" reach.

---

The module has no configuration UI and no config of its own — it works entirely through Drupal's node access grant system and the permissions page. On install it defines one static permission, `view unpublished content` ("View any unpublished content"), and dynamically generates a `view <type> unpublished content` permission for every node type via a permission callback (`UnpublishedNodePermissions::nodeTypePermissions`, extending core's `NodePermissions`). It implements `hook_node_access_records()` to write per-language view grants for unpublished nodes into realms `view_unpublished_<type>_node`, `view_unpublished_any`, and `view_unpublished_author`, and `hook_node_grants()` to hand a user the matching grants based on which of those permissions they hold (published nodes fall through to the normal `all` realm). It also swaps the Views `node_status` filter for its own `UnpublishedStatus` class and adds `hook_views_query_substitutions()` so Views listings respect the same per-type permissions. Because access is enforced through node grants, after enabling the module (or changing which roles hold these permissions) you should rebuild node access permissions for the grants to take full effect.

---

- Let editors of one content type (e.g. Article) preview unpublished Articles but not unpublished Pages.
- Give a "reviewer" role read access to unpublished content of specific types only.
- Replace the all-or-nothing core "view any unpublished content" with per-type control.
- Allow a marketing role to see unpublished Landing pages while hiding unpublished Reports.
- Grant a translator role visibility of unpublished nodes in a given type for QA.
- Expose unpublished nodes of chosen types in a View without leaking every unpublished node.
- Keep unpublished forum topics visible only to moderators of that type.
- Provide staging-like visibility of draft content per section of a site.
- Combine with workflow modules so per-type reviewers can view drafts awaiting approval.
- Give authors site-wide "view any unpublished content" only where truly needed.
- Scope unpublished visibility by role and content type through the standard permissions page.
- Let a role see unpublished nodes it authored via the author grant realm.
- Enforce the same per-type visibility in both node canonical pages and Views listings.
- Audit which roles can see unpublished content of each type from one permissions screen.
- Avoid custom node-access code by using ready-made per-type permissions.
- Support multilingual sites — grants are written per translation language.
- Hide unpublished content from anonymous users while allowing specific staff roles.
- Grant a documentation team access to unpublished Docs pages only.
- Progressive rollout: publish gradually while select roles preview unpublished items.
- Integrate with content moderation by controlling who sees not-yet-published revisions' base nodes.
- Restrict unpublished visibility to editorial roles per section in a large multi-team site.
