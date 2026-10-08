# Configure subgroups

No admin settings page. You enable subgroups per **parent group type** by installing the
derived relation plugin, then use the wizard/operations to relate or create child groups.

## Enable subgroups on a group type

1. Go to *Administration → Groups → Group types* (`/admin/group/types`), pick the **parent**
   group type → *Set available content* / *Manage plugins* (`.../content`).
2. Install the plugin **`Subgroup (<child type>)`** — machine id `ggroup:<child_group_type>`.
   One derivative exists per group type on the site (see `SubgroupDeriver`).
3. Plugin settings (schema `group_relation.config.creator_wizard`, plus Group's defaults):
   - `entity_cardinality` — **forced to 1** and disabled in the UI (a group can be related
     to a given parent only once); do not change.
   - `creator_wizard` (bool, default `0`) — when on, creating a subgroup shows the group
     form first, then a second form to complete the creator's membership. Turn on only if
     the membership has required fields. Config key: the plugin's `creator_wizard`.

Repeat with different `ggroup:<type>` plugins to allow several child types under one parent.

## Creating / relating subgroups (routes)

Provided by `SubgroupRouteProvider` + `ggroup.routing.yml`:

| Route | Path | Purpose | Access |
|---|---|---|---|
| `entity.group_relationship.ggroup_relate_page` | `/group/{group}/subgroup/add` | relate an existing group | group perm `create ggroup:<type> relationship` (any installed type) |
| `entity.group_relationship.ggroup_add_page` | `/group/{group}/subgroup/create` | pick a type to create | group perm `create ggroup:<type> entity` |
| `entity.group_relationship.ggroup_add_form` | `/group/{group}/subgroup/create/{group_type}` | the create wizard | `_subgroup_add_access` → group perm `create ggroup:<type> relationship` |

These also appear as group operation links ("Create <type>") via `SubgroupOperationProvider`.
The wizard stores the half-built group in the per-user private tempstore (`ggroup_add_temp`)
between steps.

## Circular-reference protection

`ggroup_entity_type_alter()` adds the `GroupSubgroup` constraint to `group_relationship`
entities. `GroupSubgroupConstraintValidator` rejects a relationship whose child group is
already an ancestor of the parent (would create a cycle). `SqlGroupGraphStorage::addEdge()`
also throws `CyclicGraphException` at the storage layer.

## Views: list content across subgroup levels

`ggroup_views_data_alter()` adds argument **`group_id_depth`** ("Has parent group ID (with
depth)") on `group_relationship_field_data`. Its `depth` option (checkboxes) selects which
levels to include: `-1` = target group's own content, `0/1/2` = 1/2/3 subgroup levels deep.
It joins `group_graph` on `hops` to pull descendant group content. See
`src/Plugin/views/argument/GroupIdDepth.php`.

## Tokens

`ggroup.tokens.inc` exposes, for a `group`: `[group:group]` (the parent group label) and
`[group:groups]` / chained `[group:groups:*]` (all parent groups of the group).

## Permissions

- `access ggroup overview` (module permission) — view the overview of all subgroups
  regardless of subgroup type.
- `create ggroup:<type> relationship` / `create ggroup:<type> entity` — **group** permissions
  (granted per group role in the Group UI), gating relate vs. create as in the table above.
