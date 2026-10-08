Entity Reference Integrity is an API-only base module that can tell, for any entity, whether other entities point at it through an entity_reference field. The companion submodule `entity_reference_integrity_enforce` uses it to block deletion of still-referenced entities.

---

The base module registers an entity handler (`entity_reference_integrity`) on every entity type via `hook_entity_type_alter`, backed by the service `entity_reference_integrity.field_map` (a `DependencyFieldMapGenerator`). The field-map generator scans all `entity_reference` fields site-wide (via the entity field map) and builds a map keyed by the *target* entity type → source entity type → referencing field names, skipping computed/custom-storage fields and revision-metadata fields. The handler (`EntityReferenceIntegrityEntityHandler`) then exposes `hasDependents($entity)`, `getDependentEntityIds($entity)` and `getDependentEntities($entity)`, which run entity queries (with `accessCheck(FALSE)`, OR-grouped across the referencing fields) to find content that references the given entity. By itself the base module changes no behavior — it only provides this dependency-inspection API; another module (typically the bundled enforce submodule) must act on the answers. It has no config, no permissions, no UI, and no config schema.

---

- Determine programmatically whether an entity is referenced by any other entity.
- Get the list of entity IDs (grouped by entity type) that reference a given entity.
- Load the actual referencing entities for display or reporting.
- Power a "you cannot delete this, it is in use" guard in custom code.
- Build a related-content or "used by" panel for editors.
- Detect orphan-risk before running a bulk delete.
- Reuse the field map to enumerate which fields reference a particular entity type.
- Provide the dependency data that `entity_reference_integrity_enforce` acts on.
- Check referential dependencies across all entity types, not just nodes.
- Skip computed and custom-storage fields automatically when scanning references.
- Query references efficiently with a single OR-grouped entity query per source type.
- Get a human-readable "cannot delete … it is being referenced" reason string.
- Audit which taxonomy terms, media, or users are still referenced somewhere.
- Feed reference data into a custom migration or cleanup script.
- Extend or decorate the handler to add project-specific reference rules.
