# facets — agent start

Faceted-search filter blocks built on a **Search API** index. A facet is a config entity
(`facets.facet.*`) = source + field + widget + processors. Config UI: **Admin → Config →
Search → Facets** (`/admin/config/search/facets`, route `entity.facets_facet.collection`).
No hard module dependency in info.yml, but a Search API index/view is required in practice.

- Create & configure facets (source, widget, processors, URL) → [configure/facets.md](configure/facets.md)
- Plugin types this module defines (widget, processor, query_type, url_processor, facet_source, hierarchy) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Add a custom widget or processor plugin → [plugins/widget-processor.md](plugins/widget-processor.md)
- Services & programmatic API (facets.manager, url generator) → [api/services.md](api/services.md)
- Alter hook (query-type mapping) → [hooks/hooks.md](hooks/hooks.md)
- Theme facet output (templates, hooks, suggestions) → [theming/theming.md](theming/theming.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
- Submodules: facets_exposed_filters, facets_range_widget, facets_rest, facets_searchbox_widget, facets_summary, facets_demo (documented separately).
