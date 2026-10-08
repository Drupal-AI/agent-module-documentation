<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Forum access model

## Setup
1. Enable `group_forum` (pulls in forum + group).
2. On a group type, install the **Group forum** content plugin.
3. Configure the group-type/group permissions: `create group_forum content`, `view group_forum content`, `update any group_forum entity`, `delete any group_forum entity`, and the view-unpublished variant.
4. Relate/create forum containers per group via `group/{group}/forum/add` or `.../create`.

## Enforcement (all in `group_forum.module`)
- **Taxonomy term access** (`group_forum_taxonomy_term_access`): for `view/update/delete`, loads the group content for the forum term (or walks up parent terms if the term itself isn't grouped) and allows only if some owning group grants the matching permission; otherwise forbidden.
- **Node access** (`group_forum_node_access`): forbids a forum node if any of its `taxonomy_forums` terms is forbidden by the term-access rule.
- **Listing filter** (`group_forum_query_taxonomy_term_access_alter` / vocabulary node count): excludes forbidden term ids (and their descendants) from term/vocabulary queries; a static `_group_forum_term_access_switch()` prevents recursion while gathering parents.
- **Node grants** (`group_forum_node_grants` / `group_forum_node_access_records`): realm `group_forum` grants view/update/delete per owning group; members are resolved via the membership loader, anonymous/outsider access via `GroupType::getAnonymousRole()/getOutsiderRole()` and the group role synchroniser. Users with `bypass group access` get the `group_forum_bypass` realm (gid 1986).

## Review outcome
Access consistently flows through Group permissions and Drupal node grants. The routes require `create group_forum content`; the module's own permission `access group_forum overview` only gates an overview. No anonymous or overbroad mutating route was found.
