Entity Hierarchy Breadcrumb builds a page's breadcrumb trail from its Entity Hierarchy parent field, walking the nested-set tree of ancestors instead of relying on the URL path or menu.

---

This submodule registers a `breadcrumb_builder` service (`entity_hierarchy.breadcrumb`, priority 10) that applies on canonical entity routes when the entity has an `entity_reference_hierarchy` field. In `build()` it uses the parent module's storage services — `entity_hierarchy.nested_set_storage_factory`, `entity_hierarchy.nested_set_node_factory` and `entity_hierarchy.entity_tree_node_mapper` — to fetch the entity's ancestors from the nested-set tree, load them (with access checks), and turn them into breadcrumb links in root-to-parent order, plus a Home link. It skips admin routes (via `router.admin_context`). Because the trail comes from the hierarchy field, breadcrumbs stay correct even when URLs/aliases change, and moving a node re-parents its whole subtree's breadcrumbs automatically. There is no configuration UI: enable the module and any entity type with a hierarchy field gets hierarchy-based breadcrumbs. Cacheability metadata from the ancestor entities is attached so breadcrumbs invalidate correctly.

---

- Show a page's ancestor chain (Home › Section › Subsection › Page) from its parent field.
- Replace path/menu-based breadcrumbs with structure-based ones on a page tree.
- Keep breadcrumbs correct after URL alias changes because they follow the hierarchy, not the path.
- Automatically update a subtree's breadcrumbs when a node is re-parented.
- Provide breadcrumbs for a Book-style page tree built with Entity Hierarchy.
- Give documentation sections consistent ancestor breadcrumbs without maintaining a menu.
- Drive breadcrumbs on any content entity type that has an entity_reference_hierarchy field.
- Respect access: ancestors the user cannot view are handled via access-checked loading.
- Avoid admin-route breadcrumbs (the builder does not apply on admin pages).
- Ensure breadcrumb links point at the canonical URL of each ancestor entity.
- Add a Home link at the root of every hierarchy breadcrumb.
- Support multilingual sites since ancestor entities are loaded and labelled per request.
- Use hierarchy breadcrumbs alongside the parent module's Views tree listings.
- Get breadcrumbs for deep trees cheaply by reading the precomputed nested-set ancestors.
- Deploy with zero config: enabling the module is the whole setup.
- Layer SEO-friendly breadcrumb trails onto a microsite built with Entity Hierarchy Microsites.
- Reflect editorial section structure in breadcrumbs on a content-modelled hierarchy.
- Keep breadcrumb cache tags in sync with ancestor entity changes.
- Provide breadcrumbs where core's Book module is not used but a parent field is.
- Show breadcrumbs on nodes whose place in the tree is set purely via the hierarchy field.
