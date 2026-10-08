# Entity Hierarchy — agent index

Adds an `entity_reference_hierarchy` field (entity reference + integer `weight`) that
maintains a **nested-set tree** in a per-field table `nested_set_<field>_<entity_type>`
(via `previousnext/nested-set`). Writes are expensive, reads (ancestors/descendants/
siblings) are cheap. No global settings form (`configure` is null); configuration is
per field on a bundle. One permission: `reorder entity_hierarchy children`.

- **Add the field, pick widget/formatter/selection handler, weight settings, reorder UI** →
  [configure/field.md](configure/field.md)
- **Services & programmatic API (parent candidate, nested-set storage, tree node mapper, tree rebuilder)** →
  [api/services.md](api/services.md)
- **Views arguments/relationship/field (is-child-of, is-parent-of, is-sibling-of, root, children summary)** →
  [views/plugins.md](views/plugins.md)
- **Drush command + migration write-disable / rebuild workflow** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Field type id `entity_reference_hierarchy`; default widget `entity_reference_hierarchy_autocomplete`
  (also `entity_reference_hierarchy_select`), default formatter `entity_reference_hierarchy_label`.
- Selection handler id `entity_hierarchy` (lineage-aware, loop-preventing).
- A hierarchy only makes sense within **one entity type** (parent field targets the same type).
- Submodules: `entity_hierarchy_breadcrumb`, `entity_hierarchy_microsite`,
  `entity_hierarchy_workbench_access` (documented under `../modules/`).
