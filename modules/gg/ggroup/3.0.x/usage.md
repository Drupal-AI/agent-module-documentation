Subgroup (ggroup) extends the [Group](https://www.drupal.org/project/group) module so a group can itself be a member of another group, giving you a full parent/child group hierarchy (a graph, not just a tree).

---

Subgroup adds a `ggroup` group-relation plugin, derived once per group type, that relates one group to another as a subgroup. When you install the `ggroup:<group_type>` plugin on a parent group type, that parent can hold child groups of the chosen type; a creation wizard (`/group/{group}/subgroup/create/{group_type}`) either relates an existing group or walks a two-step "create group, then complete membership" flow (the `creator_wizard` plugin setting). Every parent/child edge is recorded in a dedicated `group_graph` transitive-closure table (via `SqlGroupGraphStorage`), which precomputes all direct *and* implied ancestor/descendant edges with a `hops` count, so descendant/ancestor lookups are single indexed queries rather than recursive walks. A `GroupSubgroup` validation constraint blocks circular references (you cannot make a group a subgroup of its own descendant). The `GroupHierarchyManager` service exposes the hierarchy (`getGroupSubgroups`, `getGroupSupergroups`, their `*Ids` variants, and `groupHasSubgroup`), and the graph storage exposes lower-level `getDescendants`/`getAncestors`/`getPath`/`isDescendant`. A `group_id_depth` Views argument lets a view list group content across a configurable number of subgroup levels, and a token integration exposes `[group:groups:*]` for a group's parent groups. This 3.0.x release provides the hierarchy graph and creation UI; permission *inheritance* between parent and child groups is handled by the Group ecosystem, not baked into this module.

---

- Model an organisation → department → team structure where each level is a real Group.
- Let a "country" group contain "project" subgroups and roll their content up together.
- Build a franchise / multi-tenant hierarchy of groups with shared parent oversight.
- Nest chapters or committees under an umbrella organisation group.
- Relate an already-existing group into a parent group as a subgroup.
- Create a brand-new subgroup inside a parent through the two-step creation wizard.
- Require the subgroup creator to fill out membership fields via the `creator_wizard` flow.
- Prevent accidental circular group references (A → B → A) with the built-in constraint.
- Query all descendant groups of a given group in one call (`getGroupSubgroupIds`).
- Query all ancestor/parent groups of a given group (`getGroupSupergroupIds`).
- Check whether one group is anywhere beneath another (`groupHasSubgroup`).
- Find the path(s) between an ancestor and descendant group (`getPath`).
- Build a View of group content that spans N levels of subgroups via the depth argument.
- Show a group's parent groups in tokens/emails with `[group:groups]`.
- Gate the "Create subgroup" operation with the per-type `create ggroup:<type> ...` group permissions.
- Give a role the "Access subgroup overview" permission to browse all subgroups regardless of type.
- Provide a "Relate subgroup" / "Create subgroup" operation link on group pages.
- Programmatically add a subgroup edge from custom code via `GroupHierarchyManager::addSubgroup`.
- Remove a subgroup relationship and its implied graph edges cleanly (`removeSubgroup`).
- Drive reporting/dashboards that need the full transitive closure of group membership.
- Restructure large group trees while keeping descendant/ancestor lookups fast.
