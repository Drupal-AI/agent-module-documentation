<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Purger removes orphaned (dangling) entity-reference values from parent entities when the referenced entity is deleted, so reference fields don't keep pointing at content that no longer exists.

---

The module has no admin page of its own; it is enabled **per entity-reference field**. On a config field's *Field settings* edit form it adds an "Entity Reference Purger" section with two checkboxes — **Remove orphaned entity references** (`remove_orphaned`) and **Use queue** (`use_queue`, shown only when the first is ticked) — stored as third-party settings on the field's `FieldConfig`. For base fields you enable it in code via `->setSetting('entity_reference_purger', ['remove_orphaned' => TRUE, 'use_queue' => FALSE])`. When any entity is deleted, `hook_entity_delete()` scans every non-computed `entity_reference` field whose `target_type` matches the deleted entity's type, loads the parent entities that referenced it, and removes the matching field item(s). If **Use queue** is off it removes the item immediately and saves the parent (creating a new revision with a log message when the entity is revisionable). If **Use queue** is on it instead pushes a job onto the `entity_reference_purger` queue, and the `EntityReferencePurgerWorker` QueueWorker (cron time 60s) removes the dangling items on the next cron run — recommended when a deletion could orphan a large number of references. Computed fields are skipped. The module ships only a config-schema for the third-party settings and the queue worker; no permissions, routes, services, or Drush commands.

---

- Automatically drop a deleted node from every other node's "Related content" entity-reference field.
- Keep a "Featured articles" reference field clean when a featured article is deleted.
- Remove a deleted taxonomy term from a node's entity-reference (not the core term-reference) field.
- Purge references to a deleted media entity from parent entities that pointed at it.
- Clean up references to deleted users on a "Team members" field.
- Prevent dangling references from producing broken links or empty renders after content deletion.
- Enable orphan removal on `field_tags`-style entity-reference fields via the field settings UI.
- Defer purging to cron with the queue option when deleting an entity referenced by thousands of others.
- Process large orphan-cleanup batches in the background via the `entity_reference_purger` queue worker.
- Enable purging on a base entity-reference field from a custom module using `setSetting()`.
- Keep referential integrity on a content model without writing custom `hook_entity_delete` code.
- Create a new revision (with a descriptive log message) each time an orphaned reference is removed from a revisionable entity.
- Selectively enable purging only on the fields where dangling references matter, leaving others intact.
- Combine immediate purge on low-volume fields with queued purge on high-volume ones.
- Maintain accurate reference counts after bulk content deletions.
- Avoid orphaned references breaking Views that join on entity-reference targets.
- Clean references after migrating/removing legacy content.
- Ensure exported field config carries the purge settings (`third_party_settings.entity_reference_purger`) across environments.
- Turn purging off again by unticking "Remove orphaned entity references" on the field.
- Handle references to any entity type (node, term, user, media, custom) uniformly.
- Reduce manual database cleanup of `*__target_id` rows after deletions.
- Keep Paragraphs or custom entity reference relationships tidy when a target is deleted.
