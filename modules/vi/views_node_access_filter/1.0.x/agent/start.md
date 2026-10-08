# Views Node Access Filter — agent index

Adds a non-exposable Views filter **"Editable"** to the Content (`node_field_data`) and Content
revision (`node_field_revision`) tables that limits results to nodes the current user can UPDATE.
Depends on `node` + `views`. No config UI (`configure` null), no permissions, no Drush, no schema.
SQL Views only.

- **How the filter works, how to add it, the fail-closed access design, the node-grants it registers,
  and the caveats** → [configure/filter.md](configure/filter.md)

Key facts:
- Filter id `views_node_access_filter_editable` (plugin `Editable`); `field` = `nid`
  (`node_field_data`) / `vid` (`node_field_revision`). `canExpose()` = FALSE — never exposable.
- Query is tagged `node_access` with metadata `op = update`, so core's
  `node_query_node_access_alter()` applies the UPDATE-access join (fail-closed; ADDS a constraint).
- Registers `hook_node_grants()` / `hook_node_access_records()` with `grant_view = 0` (edit grants
  only); `hook_node_access_records_alter()` re-adds core's default VIEW grant only when no other
  node-access module defined records, so it never widens view access.
- Grants rebuilt on role change, node save, permission save, module enable/disable, and on install.
