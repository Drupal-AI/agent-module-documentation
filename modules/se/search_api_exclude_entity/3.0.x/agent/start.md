# search_api_exclude_entity — agent start

Adds a `search_api_exclude_entity` boolean field (with widget + formatter) to entity bundles;
a Search API `alter_items` processor (`search_api_exclude_entity_processor`) drops flagged
items during indexing. Depends on core `field` and `search_api`. No dedicated config route —
setup is done on the Field UI and the Search API index's processor tab. Package: Search.

- Add the exclude field + enable/configure the processor on an index → [configure/search_api_exclude_entity.md](configure/search_api_exclude_entity.md)
- The plugins it provides (field type, widget, formatter, processor, sync) → [plugins/search_api_exclude_entity.md](plugins/search_api_exclude_entity.md)
- Submodules: `search_api_exclude_entity_by_field` (exclude by field value), `search_api_exclude_entity_metatag` (exclude on `robots: noindex`) — nested under `modules/`.
