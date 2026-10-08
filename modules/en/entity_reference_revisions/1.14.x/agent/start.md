# entity_reference_revisions — agent start

Provides an `entity_reference_revisions` field type that stores a target **entity ID + target
revision ID**, so a host revision pins the exact child revisions it owns. Foundation for
composite/child entities (Paragraphs). Depends on core `field`. No config UI.

- Add/configure the ERR field, widget & formatters → [configure/field.md](configure/field.md)
- Composite entities, needs-save, field-item API in code → [api/composite-entities.md](api/composite-entities.md)
- Orphan cleanup: drush `err:purge`, form, queue, permission → [drush/orphan-purge.md](drush/orphan-purge.md)
