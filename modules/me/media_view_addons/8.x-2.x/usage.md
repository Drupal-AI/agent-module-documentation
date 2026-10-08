<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enhances the media administration View by adding a field that lists the nodes using each media item.

---

A Views field plugin `MediaViewAddonsNodesField` (`@ViewsField("media_view_addons_nodes_field")`) renders, per media row, a dropdown of edit links to the top-level nodes that reference that media. It reads the row's `mid`, then calls the `media_view_addons.relationship_manager` service (`EntityRelationshipManager`) which builds an entity-reference map across `node` and `paragraph` bundles (`entity_field.manager`) and recursively resolves references up to the owning node: `topLevelNids()` queries each `{entity}__{field}` table for rows whose `<field>_target_id` matches, following paragraph->parent chains up to a nesting limit of 5. Other modules can alter the resulting links via `hook_media_view_addons_links()`. The reference field/table names come from field definitions (config), not request input, so the dynamic SQL is not user-controlled. No routes, permissions, config or forms of its own; it is used by placing the field on a media View.

---

- Show which nodes use a given media item directly from the media admin listing.
- Traverse paragraph nesting to find the real owning node of an embedded media.
- Provide one-click edit links to each referencing node.
- Audit media usage before deleting or replacing an asset.
- Identify orphaned media that no node references.
- Render referencing-node links as an admin operations-style dropdown.
- Let other modules extend the links list via `hook_media_view_addons_links()`.
- Add the field to any media View via the Views UI.
- Support both node and paragraph reference chains (up to 5 levels deep).
- Cache the field output against the `node_list` cache tag.
- Help DAM workflows understand asset reuse across the site.
- Avoid manual grep of the database to find media usage.
- Work on Drupal 8/9/10 with the core Media and Views modules.
- Prevent infinite loops via a recursion nesting limit.
- Complement core's usage tracking with editable node links.
- Surface reverse entity-reference relationships in a listing context.
