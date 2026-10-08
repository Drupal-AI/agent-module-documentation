# Entity Hierarchy Workbench Access — agent index

Adds a Workbench Access **access-control-hierarchy plugin** (`id = entity_hierarchy`) so a
Workbench Access *access scheme* can use an `entity_reference_hierarchy` field as its section
hierarchy. A "section" is a node in the tree; membership includes that node and all its
nested-set descendants.

- **Create the access scheme, how sections/ancestry/validation work, cache bin** →
  [configure/access-scheme.md](configure/access-scheme.md)

Key facts:
- Plugin id `entity_hierarchy` (`@AccessControlHierarchy`), derived per hierarchy field by
  `WorkbenchAccessControlDeriver`.
- Depends on `workbench_access` and `entity_hierarchy`. Configured entirely through Workbench
  Access's access-scheme UI (`/admin/config/workflow/workbench_access`); no own settings page.
- Adds a `ValidHierarchySection` constraint to the hierarchy field on covered bundles.
- Uses a dedicated cache bin `entity_hierarchy_wba`; resolves ancestry via the parent
  module's `NestedSetStorageFactory`.
