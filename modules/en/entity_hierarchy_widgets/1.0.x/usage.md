Entity Hierarchy Widgets adds editorial and display widgets for the Entity Hierarchy module: a drag-and-drop tree reorder form, a nested entity-reference selection plugin, and a hierarchy menu block.

---

Entity Hierarchy Widgets extends Entity Hierarchy (`entity_reference_hierarchy`) with the UI it does not ship on its own. For any content entity type that has an `entity_reference_hierarchy` field, the module adds a **Hierarchy** local task tab at `{canonical}/hierarchy` whose form shows the entire tree in a `tabledrag` table so editors can re-parent and reorder every node in one save (not just an entity's direct children), applying the changes through a Batch API run. It also registers an `entity_hierarchy_nested` entity-reference selection plugin that renders referenceable entities as an indented, depth-prefixed tree — the same experience as selecting a hierarchical taxonomy term — and an **Entity Hierarchy Menu** block that renders the current entity's hierarchy as a nested `<ul>` link list with the active item marked. Reordering is gated by the `reorder entity_hierarchy_widgets hierarchy` permission plus view access to the entity. It requires Entity Hierarchy 5.x and core 10.5+/11.2+/12.

---

- Add a whole-tree drag-and-drop reorder form to any entity type that has an entity_reference_hierarchy field.
- Re-parent an entity by dragging it under a different parent in the hierarchy table.
- Reorder siblings within the same parent by changing their weight via tabledrag.
- Reorganize an entire content hierarchy in a single form submission instead of editing each entity.
- Reach the reorder form from the automatically-added "Hierarchy" tab on an entity's canonical page.
- Restrict who can reorder hierarchies with the "Reorder hierarchy" permission.
- Let editors pick a parent from an indented tree using the "Entity Hierarchy nested" reference selection handler.
- Configure a hierarchy reference field's widget to show options as a nested, depth-prefixed list like hierarchical taxonomy terms.
- Present deeply nested reference options so editors see structure, not a flat list.
- Display the current entity's hierarchy as a navigation menu via the "Entity Hierarchy Menu" block.
- Show a nested link list of a page's ancestors, siblings, and descendants in a sidebar or region.
- Highlight the currently viewed item in the hierarchy menu (in-active-trail class).
- Build section navigation for book-like or documentation content organized with Entity Hierarchy.
- Provide breadcrumb-style or table-of-contents navigation from the entity hierarchy tree.
- Support any content entity type (nodes, custom entities) that carries a hierarchy field, not just nodes.
- Choose which hierarchy field to reorder when an entity type has more than one.
- Apply large reorder operations reliably through Batch API without timeouts.
- Keep block output cache-aware with url, user, and route.group contexts and per-bundle list cache tags.
- Offer Edit and Delete operation links per row in the reorder table for entities the user may change.
- Give site builders a ready-made tree UI without writing a custom form for each hierarchy.
- Manage taxonomy-like parent/child structures on content entities using Entity Hierarchy's data model.
