<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes Entity Hierarchy tree maintenance run when a parent entity is soft-deleted with the Trash module, so orphaned children are reparented to their grandparent instead of being left pointing at a trashed parent.

---

Entity Hierarchy Trash Support is a small bridge module between `entity_hierarchy` (Entity Reference Hierarchy) and `trash` (soft-delete / recycle bin). By default the Trash module soft-deletes an entity by setting its `deleted` flag rather than firing the normal delete hooks, so entity_hierarchy never gets a chance to fix up the tree. This module implements `hook_entity_update`, detects that an update is really a trash operation (a content entity whose `deleted` field is now set), and runs entity_hierarchy's tree-maintenance logic: every child of the trashed parent is moved up to the trashed entity's own parent (its grandparent) or to the root if there was none. The trashed entity keeps its own parent reference so the hierarchy can be reconstructed if it is later restored. The module ships no configuration UI, routes, permissions, config schema or plugins — it is purely a behavioral hook. Requires entity_hierarchy 5.x and the Trash module; supports Drupal 10.5+ and 11.2+.

---

- Keep an entity_hierarchy tree consistent when nodes are soft-deleted instead of hard-deleted.
- Reparent children of a trashed parent up to their grandparent automatically.
- Move children to the tree root when the trashed parent had no parent of its own.
- Preserve the trashed entity's own parent reference so it restores into a sensible place.
- Run entity_hierarchy's post-delete tree maintenance on trash operations, which Trash otherwise skips.
- Use the Trash module's recycle-bin workflow on hierarchical content types.
- Avoid dangling parent references pointing at entities that are no longer visible.
- Let editors soft-delete a hierarchy parent without breaking its descendants' navigation.
- Bridge the entity_hierarchy and trash ecosystems without custom code.
- Support any entity type that entity_hierarchy manages (nodes, taxonomy terms, custom content entities) plus Trash.
- Ensure child entities are re-saved with a valid parent immediately after a parent is trashed.
- Maintain breadcrumb / menu structures derived from entity_hierarchy after a soft-delete.
- Provide safe-deletion behavior for editorial teams that use Trash as an undo buffer.
- Keep hierarchy queries returning coherent trees even while a parent sits in the trash.
- Complement entity_hierarchy's existing hard-delete reparenting with equivalent trash handling.
- Install as a drop-in dependency alongside entity_hierarchy 5.x and Trash with no post-install steps.
- Only act on default-revision trash operations, leaving pending revisions untouched.
- Apply reparenting across every entity_hierarchy parent field configured on the entity.
- Work transparently whenever content is trashed via the UI, Views bulk operations or code.
- Reduce editorial cleanup after removing a section or category from a hierarchy.
