# Schema.org Blueprints (base) — agent index

Map a Drupal entity type/bundle to a **Schema.org type**; the module creates the bundle and fields from the
type's properties. Core concept: `schemadotorg_mapping` (bundle↔type + field↔property) and
`schemadotorg_mapping_type` (per-entity-type recommended/default types + naming) config entities, driven by
the bundled Schema.org vocabulary (CSV) via a handful of services. Single permission `administer schemadotorg`.

> **Scope:** this pass documents ONLY the base `schemadotorg` module from source. It ships ~52 submodules
> (JSON-LD, JSON:API, UI, node/taxonomy/media/paragraphs, many contrib integrations) — **none are enabled**
> and all are out of scope here. Notably, adding mappings **via UI** requires the `schemadotorg_ui`
> submodule; the base module is programmatic (Drush + services).

- **Config entities, settings config, admin routes** → [configure/mappings-and-settings.md](configure/mappings-and-settings.md)
- **Services API (vocabulary manager, names, mapping manager, builders)** → [api/services.md](api/services.md)
- **Drush commands** → [drush/drush.md](drush/drush.md)
- **Alter hooks** → [hooks/hooks.md](hooks/hooks.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Admin landing `/admin/config/schemadotorg` (route `schemadotorg`); settings tabs under
  `/admin/config/schemadotorg/settings/{general,types,properties,names}`; mappings list at
  `/admin/config/schemadotorg/mappings`. All require `administer schemadotorg`.
- No plugin types of its own. Provides Drush commands, config schema, and one permission.
- Services (ids): `schemadotorg.schema_type_manager`, `schemadotorg.names`, `schemadotorg.mapping_manager`,
  `schemadotorg.entity_type_builder`, `schemadotorg.entity_field_manager`, `schemadotorg.config_manager`,
  `schemadotorg.installer`, `schemadotorg.schema_type_builder`.
