# Entity Reference Integrity — agent index

API-only base module: installs an `entity_reference_integrity` entity handler on every
entity type and a field-map service to answer "does anything reference this entity?". No
config, no permissions, no UI. The enforcement (blocking deletes) lives in the submodule.

- **The handler API, the field-map service, and how to call them** →
  [api/handler.md](api/handler.md)

Submodule (own docs):
- `entity_reference_integrity_enforce` →
  [../../modules/entity_reference_integrity_enforce/2.0.x/agent/start.md](../../modules/entity_reference_integrity_enforce/2.0.x/agent/start.md)

Key facts:
- `hook_entity_type_alter` sets handler class `EntityReferenceIntegrityEntityHandler` on each
  entity type that lacks one; get it with
  `\Drupal::entityTypeManager()->getHandler($entity_type_id, 'entity_reference_integrity')`.
- Service `entity_reference_integrity.field_map` (`DependencyFieldMapGenerator`) builds a
  target→source→fields map of all `entity_reference` fields.
- Queries use `accessCheck(FALSE)`; the base module only *reports* dependencies, it enforces
  nothing on its own.
