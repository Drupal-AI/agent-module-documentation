Entity Hierarchy Workbench Access lets Workbench Access use an Entity Hierarchy field as its editorial access hierarchy, so you can grant editors control over a node and everything beneath it in the tree.

---

This submodule provides a Workbench Access `AccessControlHierarchy` plugin with id
`entity_hierarchy` (derived per hierarchy field via `WorkbenchAccessControlDeriver`) that maps
Workbench Access "sections" onto an Entity Hierarchy tree: a section is a node in the tree, and
membership of a section includes that node and all its nested-set descendants. You create a
Workbench Access **access scheme** of type "Entity hierarchy" (choosing the entity type and
the `entity_reference_hierarchy` field), then assign users/roles to sections (nodes) as usual;
the plugin resolves ancestry from the parent module's `NestedSetStorageFactory`, caching the
tree in a dedicated `entity_hierarchy_wba` cache bin. It adds a `ValidHierarchySection`
constraint to the hierarchy field on relevant bundles (via
`hook_entity_bundle_field_info_alter`) so editors cannot move content outside a section they
lack access to, and it maps scheme settings (`boolean_fields`, `bundles`) when a scheme is
saved. There is no standalone settings page — configuration happens through Workbench Access's
own access-scheme admin UI.

---

- Give an editor edit access to a section node and automatically to all its descendant pages.
- Model editorial sections on an existing Entity Hierarchy page tree instead of taxonomy.
- Delegate a whole branch of the site to a team without listing every node.
- Restrict which part of the hierarchy a user can file content under.
- Prevent editors from re-parenting content into a section they cannot access (validation constraint).
- Scope Workbench Access permissions to structural sections that follow the content tree.
- Let access follow the tree: moving a node moves its access section membership with it.
- Combine hierarchy-based editorial access with content moderation workflows.
- Assign roles to top-level sections so access cascades down the hierarchy.
- Build a departmental content ownership model over one shared page tree.
- Use nested-set ancestry to compute a user's effective sections efficiently.
- Cache the section tree separately (entity_hierarchy_wba bin) for performance.
- Create multiple access schemes over different hierarchy fields/entity types.
- Enforce section boundaries on node create and edit forms.
- Grant a contractor access to just one microsite/section subtree.
- Keep editorial access correct as the hierarchy is reorganised.
- Provide ancestry-labelled section options in the Workbench Access UI.
- Map an org chart hierarchy to editorial permissions.
- Limit content listings/dashboards to a user's assigned hierarchy sections (via Workbench Access).
- Replace menu- or taxonomy-based Workbench Access schemes with a hierarchy-field scheme.
