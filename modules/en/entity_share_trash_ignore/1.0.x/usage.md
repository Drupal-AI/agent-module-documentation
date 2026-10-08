<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Share Trash Ignore adds an Entity Share Client import processor that skips importing any entity that already exists in the local Trash bin.

---

Entity Share Trash Ignore is a small bridge between **Entity Share** (JSON:API content syndication between Drupal sites) and the **Trash** module. When content is imported through Entity Share Client and then soft-deleted into the Trash bin on the target site, Entity Share still lists that entity as new and offers to import it again. Re-importing it would fail with a 500 error, because Entity Share tries to create a brand-new entity while the trashed copy still holds the same UUID. This module registers a locked import processor (`trash_ignore`) that runs during the "is this entity importable" stage of the import pipeline: for entity types/bundles that Trash manages, it looks up the local entity by UUID inside the Trash "inactive" context and, if that entity is currently in the trash, skips the import and shows the operator a message instead of erroring. It only affects the client (import) side of Entity Share and requires no configuration.

The processor is active as long as the module is enabled — there is nothing to configure and no settings form of its own. It depends on Entity Share Client and Trash (Entity Share `^3 || ^4`, Trash `^3`), sits in the Web services package, and has no permissions, routes, or services of its own. Install it on any Entity Share client site that also uses Trash to prevent import failures on previously-deleted content.

---

- Skip importing an entity that is currently in the local Trash bin during Entity Share sync.
- Prevent the 500 server error that occurs when re-importing an entity whose UUID is still held by a trashed entity.
- Bridge the Entity Share Client import pipeline with the Trash (soft-delete) module.
- Keep re-listed "new" entities from resurrecting content an editor intentionally trashed on the target site.
- Work out of the box: the processor is locked and active as soon as the module is enabled.
- Require no settings form, permissions, or routes to operate.
- Detect trashed entities per entity type and bundle, only for types Trash actually manages.
- Match incoming JSON:API entities to local ones by UUID before deciding importability.
- Look up potentially-trashed entities using the Trash "inactive" context so soft-deleted entities are found.
- Let non-trash-managed entity types import normally, unaffected by the processor.
- Let entities that exist locally but are not trashed import normally.
- Show the operator a clear error message naming the entity that was skipped for being in the trash.
- Log a warning to the site log whenever a trashed entity is skipped during import.
- Run early in the import decision stage (`is_entity_importable`, weight -5) so trashed content is filtered before other checks.
- Support Drupal 10 and 11 client sites that pull content from an Entity Share source.
- Complement full-content and channel-based Entity Share import workflows.
- Reduce manual cleanup for editors who repeatedly see trashed content re-offered for import.
- Protect scheduled or batch Entity Share imports from failing on a single trashed entity.
- Serve multi-site content staging setups where the target site soft-deletes rather than hard-deletes content.
- Install alongside Entity Share Client and Trash with no additional dependencies or libraries.
- Avoid re-importing content that would otherwise need to be permanently purged from trash first.
