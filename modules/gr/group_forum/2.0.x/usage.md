<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Forum lets forum containers (and the nodes posted in them) be related to Group entities so their visibility and editing follow Group permissions.
---
It ships a `GroupContentEnabler` plugin (`group_forum`) that relates the `forums` taxonomy vocabulary terms to groups (cardinality forced to 1), plus a route provider adding `group/{group}/forum/add` and `group/{group}/forum/create` routes guarded by the group permission `create group_forum content`. The heavy lifting is access enforcement: `hook_ENTITY_TYPE_access()` for taxonomy terms and forum nodes checks the owning group's `view/update/delete group_forum` permissions (walking up the forum-term parent hierarchy), a `hook_query_TAG_alter()` hides forbidden forum terms from vocabulary/term listings, and `hook_node_grants()` / `hook_node_access_records()` implement the node access-grant realm `group_forum` (with a `group_forum_bypass` realm for users holding `bypass group access`). Anonymous/outsider access is derived per group type via the Group role synchroniser.

Access is therefore enforced through Group's own permission system and Drupal's node grants — a user only sees or edits group forum content where their group membership/role grants it, and the grants realm makes this apply to node listings and views too. Review note: access checks are consistently routed through `$group->hasPermission(...)` and the node-grant realm; the term-access query alter deliberately toggles a static switch to avoid recursion while computing excluded tids. No access-bypass or overbroad route was observed (the add/create routes require `create group_forum content`; the only module permission, `access group_forum overview`, gates a report/overview). No security findings.
---
- Enable the `group_forum` content plugin on a group type.
- Relate an existing forum container to a group.
- Create a new forum container inside a group.
- Restrict who can add forums via `create group_forum content`.
- Scope forum visibility to group members.
- Hide group forum terms from users lacking view access.
- Enforce update/delete of forum content by group permission.
- Grant sitewide access with `bypass group access`.
- Provide per-group private discussion forums.
- Derive anonymous/outsider forum access from group type roles.
- Expose a group forum overview (permission `access group_forum overview`).
- Use the bundled `views.view.group_forum` overview view.
- Keep forum node listings correct via node access grants.
- Build community sub-sites where each group runs its own forum.
- Allow group members to post forum topics within their group.
- Prevent non-members from viewing a group's private forum.
- Walk the forum term hierarchy so child forums inherit access.
- Give trusted staff a sitewide forum bypass permission.