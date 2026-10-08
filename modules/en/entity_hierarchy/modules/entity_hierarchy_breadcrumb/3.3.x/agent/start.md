# Entity Hierarchy Breadcrumb — agent index

Builds breadcrumbs from an entity's Entity Hierarchy parent field (the nested-set ancestor
chain) instead of the URL path or a menu. **No configuration** — enable it and every entity
type with an `entity_reference_hierarchy` field gets hierarchy breadcrumbs.

- **How the breadcrumb builder works, when it applies, and how to override/order it** →
  [configure/breadcrumbs.md](configure/breadcrumbs.md)

Key facts:
- Service `entity_hierarchy.breadcrumb` (class `HierarchyBasedBreadcrumbBuilder`),
  tag `breadcrumb_builder` priority `10`.
- `applies()` is true on a canonical, non-admin entity route when the entity has a
  hierarchy field; `build()` reads ancestors via the parent module's storage services.
- Depends only on `entity_hierarchy`. No permissions, no Drush, no config schema.
