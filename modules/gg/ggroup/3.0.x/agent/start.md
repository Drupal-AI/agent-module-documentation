# Subgroup (ggroup) — agent index

Extends Group (`drupal/group:^3.0`) so a group can be a subgroup of another group. Adds a
`ggroup:<group_type>` group-relation plugin (one derivative per group type), a two-step
creation wizard, a `group_graph` transitive-closure table, a circular-reference constraint,
a Views depth argument, and parent-group tokens. No global config page (`configure` null);
config is per group type via the relation plugin. Depends on `group`.

- **Enable a group type as a subgroup, `creator_wizard` setting, wizard routes, the depth
  Views argument, tokens** → [configure/subgroup.md](configure/subgroup.md)
- **`GroupHierarchyManager` + `SqlGroupGraphStorage` services: descendant/ancestor/path
  lookups and how the graph table works, for custom code** → [api/hierarchy.md](api/hierarchy.md)

Key facts:
- Relation plugin id: `ggroup` (attribute `#[GroupRelationType]`), deriver
  `SubgroupDeriver` makes a `ggroup:<type>` per group type. Cardinality forced to 1.
- Group permissions (per plugin, from Group's routing): `create ggroup:<type> relationship`
  (relate), `create ggroup:<type> entity` (create). Module permission (`ggroup.group.permissions.yml`):
  `access ggroup overview`.
- Hierarchy table `group_graph` (schema in `ggroup.install`): columns `start_vertex`,
  `end_vertex`, `hops` (0 = direct edge) plus entry/direct/exit edge ids — a materialised
  transitive closure maintained on relate/unrelate.
- No permission inheritance logic ships in this 3.0.x code; ggroup only builds the hierarchy
  graph + UI.
