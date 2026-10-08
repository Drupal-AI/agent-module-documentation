# eck (Entity Construction Kit) — agent start

Create custom **content entity types** + **bundles** from the UI or code, no custom module
needed. Two config entities drive everything: `eck_entity_type` (the type) and a
dynamically-registered `{type}_type` bundle entity (`eck.eck_type.{type}.{bundle}`).
Saving an `eck_entity_type` installs a real content entity type with tables `{id}` +
`{id}_field_data`. Structure UI at `/admin/structure/eck` (configure route
`eck.entity.type.list`, id `eck.entity_type.list`); content at `/admin/content/{type}`.
No module dependencies; core only.

- Create/configure entity types & bundles, base fields, settings, config names → [configure/eck.md](configure/eck.md)
- Create types/bundles/entities in code; storage, load, delete APIs → [api/eck.md](api/eck.md)
- The dynamic content-entity-type + bundle-entity-type definitions ECK builds → [plugins/eck.md](plugins/eck.md)
- Static + dynamically-generated per-type permissions → [permissions/eck.md](permissions/eck.md)
