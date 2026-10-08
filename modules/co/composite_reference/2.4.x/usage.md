<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Composite Reference lets you mark an entity reference (or entity reference revisions) field as "composite", so that the entities it points to are automatically deleted when the referencing (host) entity is deleted — implementing composite/parent-child ownership semantics for referenced content.

---

The module adds a "Composite reference" checkbox to the field configuration form of any `entity_reference` or `entity_reference_revisions` field (`hook_form_field_config_edit_form_alter`), stored as a third-party setting (`composite_reference.composite`). For revision-capable reference fields it adds a second option, "Include past revisions" (`composite_revisions`), which also deletes entities that were only referenced in older revisions. Base fields can opt in by setting `'composite_reference' => TRUE` in the field's `setSettings()`, and a `base_field_override` presave hook mirrors that into exported third-party settings so it survives overrides. Deletion is driven by `hook_entity_predelete()`: for each applicable field on the entity being deleted, the `CompositeReferenceFieldManager` service collects the referenced entities and deletes each one **unless** it is still referenced by another entity (it queries all reference/reference-revision fields site-wide, across all revisions, to check). This guards against removing a referenced entity that is shared, so the module documents that composite references should be used for entities referenced only once. There is no admin page, no permissions, and no Drush commands — it is pure field configuration plus deletion behavior. Works with both configurable (bundle) fields and base fields, and understands dedicated revision tables when the "include past revisions" option is enabled.

---

- Auto-delete a referenced Paragraph when the node that contains it is deleted.
- Give referenced media/child entities parent-owned lifecycle so they don't become orphans.
- Mark an `entity_reference_revisions` field as composite to clean up its referenced revisions on host deletion.
- Also purge entities that were referenced only in previous revisions via the "Include past revisions" option.
- Implement composite (parent owns child) semantics without writing custom `hook_entity_predelete` code.
- Prevent deletion of a shared referenced entity by relying on the module's cross-site reference check.
- Add composite behavior to a bundle field from the field settings UI with a single checkbox.
- Add composite behavior to a base field in code with `'composite_reference' => TRUE` in field settings.
- Keep composite settings on a base field working after a base field override (settings are exported).
- Clean up child entities of a custom content entity type automatically on parent deletion.
- Model a "page and its blocks/sections" relationship where deleting the page removes its owned pieces.
- Reduce orphaned-entity buildup from repeated create/delete cycles of container entities.
- Query which entities reference a given entity programmatically via the field manager service.
- Combine with entity reference revisions (Paragraphs) to fully manage nested content deletion.
- Enforce that only single-parent referenced entities are auto-deleted, leaving multi-referenced ones intact.
- Avoid maintaining custom cleanup cron jobs for referenced child content.
- Apply composite deletion selectively per field/bundle rather than globally.
- Keep referential cleanup consistent across configurable and base fields on the same entity type.
