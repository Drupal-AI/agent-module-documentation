Entity Hierarchy adds a special entity-reference field type (`entity_reference_hierarchy`) that stores a parent reference plus a weight, and maintains a nested-set tree of the entities behind the scenes so ancestors, descendants and siblings can be queried cheaply.

---

The module provides an `entity_reference_hierarchy` field type (extending core's entity reference item with an integer `weight` property) that you add to a bundle, typically pointing entities of the same type at each other to build a tree (a node's "parent"). On every entity save/delete it writes the position into a per-field nested-set table (`nested_set_<field>_<entity_type>`) via the `previousnext/nested-set` DBAL library, so the expensive tree bookkeeping happens on write and reads (all ancestors, all descendants, siblings) are cheap. It ships autocomplete and select widgets (with an optional hidden weight), a label formatter, and an `entity_hierarchy` entity-reference selection handler that shows lineage and prevents choosing a target that would create a loop (validated by `ValidHierarchyReferenceConstraint`). A "Reorder children" local task (route `entity.<type>.entity_hierarchy_reorder`, gated by the `reorder entity_hierarchy children` permission) gives a drag-and-drop form for ordering a parent's direct children. It exposes rich Views integration: relationship `entity_hierarchy_root` and arguments for is-child-of / is-parent-of / is-sibling-of an entity (with depth), plus a children-summary field. Because writes are costly, it can be paused during migration with the `entity_hierarchy_disable_writes` state flag and the whole tree rebuilt afterwards with `drush entity-hierarchy:rebuild-tree`. Submodules add breadcrumbs, microsites, and Workbench Access integration on top of the tree.

---

- Build a page tree (parent/child) as a lightweight replacement for the core Book module.
- Give content types a "Parent" field so editors can nest pages under other pages.
- Maintain a taxonomy-like hierarchy over content entities without using taxonomy terms.
- Order sibling pages manually with a drag-and-drop "Reorder children" screen.
- Query all descendants of a given node efficiently in a View (is-child-of argument).
- Query the full ancestor chain of a node for breadcrumbs or navigation (is-parent-of argument).
- List the siblings of a node, optionally including or excluding itself.
- Limit a child listing to a fixed depth (e.g. only direct children) via the argument depth setting.
- Add a "root ancestor" relationship in Views to group content by its top-level section.
- Show a summary of how many children an entity has in a Views field.
- Prevent editors from selecting a parent that would create a cycle in the tree.
- Restrict which bundles can be chosen as a parent through the reference field's target bundles.
- Use the lineage-aware selection handler so the autocomplete shows a node's ancestry.
- Hide the weight sub-field from editors while still keeping deterministic sibling order.
- Drive a microsite/section site whose pages all descend from one landing node (via submodule).
- Generate breadcrumbs that follow the hierarchy field instead of the URL path (via submodule).
- Scope Workbench Access editorial sections to the content hierarchy (via submodule).
- Disable hierarchy writes during a large migration, then rebuild the tree in one batch.
- Rebuild a field's nested-set table after bulk imports with `drush entity-hierarchy:rebuild-tree`.
- Model an organisational chart or category tree over any fieldable content entity.
- Keep menu-free structural navigation that survives URL/alias changes.
- Reorder a knowledge-base article's sub-articles without editing each node's weight by hand.
- Move a whole subtree by re-parenting a single node (descendants follow automatically).
- Expose "child pages" blocks/listings on a section landing page using the child-of argument.
- Enforce a maximum nesting behaviour by validating parent references on save.
