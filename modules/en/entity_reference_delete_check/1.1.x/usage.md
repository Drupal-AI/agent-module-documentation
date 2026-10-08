Entity Reference Delete Check adds a notice to any content entity's delete confirm form listing the other content that still references it through entity-reference fields.

---

When you enable Entity Reference Delete Check, every core content-entity delete confirmation form (nodes, taxonomy terms, media, users, custom content entities, paragraphs, and so on) gains an extra section listing the entities and fields that still point at the item you are about to delete. It works by scanning all fieldable entity types and bundles for `entity_reference` fields whose target type matches the entity being deleted, running an access-checked entity query for matches, and rendering them as a bullet list — with a link to each referencing entity when a URL can be resolved. The module is purely informational: it surfaces dangling-reference risk so an editor can decide, but it does not block, cancel, or alter the deletion itself and adds no configuration, permissions, or routes. An optional `entity_reference_delete_check_paragraph_url` submodule improves the links for entities referenced inside Paragraphs by walking up to the paragraph's host page.

---

- Warn an editor before they delete a taxonomy term that is still assigned to published articles.
- Show, on a node's delete form, every other node that references it through an entity-reference field.
- List the exact field label and referencing entity so an editor knows where a value is used.
- Give each referenced-in entity a clickable link straight from the delete confirmation page.
- Catch references to a media item before it is deleted and leaves broken embeds.
- Reveal that a user account is referenced (for example as an author reference) before removal.
- Help content teams avoid accidentally creating dangling entity references.
- Surface usages across all content entity types, not just nodes.
- Detect references coming from custom content entities that implement fieldable entities.
- Cover references stored on any bundle of any entity type in one pass.
- Provide a delete-time referential-integrity sanity check without a separate reporting page.
- Let editors self-serve the "is this safe to delete?" question at the moment of deletion.
- Respect the current user's view access, so only references they may see are listed.
- Improve paragraph reference links via the paragraph_url submodule so they point at the host page.
- Assist migrations and content cleanups by exposing where an entity is still wired in.
- Reduce support tickets caused by silently broken references after a delete.
- Complement full usage-tracking modules by giving a lightweight, delete-time-only check.
- Extend the reference-link resolution with a custom event subscriber for your own entity types.
- Give reviewers context during bulk content pruning about which items are still referenced.
- Confirm that an entity is unreferenced (no notice appears) before safely deleting it.
