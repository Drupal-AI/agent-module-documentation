# PrevNext — agent index

Adds "Previous"/"Next" links between sibling entities (same type/bundle/language, ordered by
entity ID) to entity displays. Enable per entity type+bundle at
`/admin/config/user-interface/prevnext` (route `prevnext.admin_settings`). No dependencies beyond
core; provides config schema + permissions; no Drush; no plugin types.

- **Enable per type/bundle, the three render methods (pseudo-fields, block, Views field), infinite loop, settings keys** → [configure/settings.md](configure/settings.md)
- **`prevnext.service` API: `buildEntityLinks()` / `getPreviousNext()`, the neighbour query, caching, theme hook** → [api/service.md](api/service.md)
- **Global vs dynamic per-entity-type permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `prevnext.settings`: `prevnext_enabled_entity_types` (map), `prevnext_enabled_entity_bundles` (map type→bundles), `prevnext_infinite_loop` (bool).
- Neighbour query: `status=1`, current bundle + langcode, `id < / > current`, `range(0,1)`, `accessCheck()`.
- Pseudo-fields `prevnext_previous` / `prevnext_next` (must be enabled on *Manage display*); block id `prevnext_block`; Views field `prevnext_links_field`.
- Theme hook `prevnext` (`templates/prevnext.html.twig`), vars: direction, text, id, url, entity.
