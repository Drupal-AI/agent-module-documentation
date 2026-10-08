# Configure Entity Clone

Two admin pages (permission `administer entity clone`):

## Settings — `/admin/config/system/entity-clone` (route `entity_clone.settings`)
Config object `entity_clone.settings`:
- `no_suffix` (bool) — if TRUE, do **not** append the "(cloned)"/suffix to the new label.
- `take_ownership` (bool) — set the cloning user as owner of the new entity.
- `handle_bundles` (bool) — expose per-bundle rows (not just per-entity-type).
- `form_settings` — sequence keyed by entity type (and bundle when `handle_bundles`), each a
  `entity_clone.entity_type.settings` mapping:
  - `default_value` (bool) — reference fields on this type clone by default.
  - `disable` (bool) — disable cloning for this type.
  - `hidden` (bool) — hide this type's reference fields from the clone form.

## Cloneable entities — `/admin/config/system/entity-clone/cloneable-entities` (route `entity_clone.cloneable_entities`)
Config object `entity_clone.cloneable_entities`, key `cloneable_entities`: a sequence of entity
type ids that are allowed to be cloned (controls which types show the Clone operation).

Both are exportable config (`config/sync/entity_clone.settings.yml`,
`entity_clone.cloneable_entities.yml`); schema in `config/schema/entity_clone.settings.schema.yml`.
