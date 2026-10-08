# entity_print — agent start

Renders any content entity to PDF (and EPub/Word) via a pluggable **print engine** (default
Dompdf). Depends on core `file` + `image`. View route: `print/{export_type}/{entity_type}/{id}`
(add `/debug` for raw HTML). Config UI: **Admin → Config → Content authoring → Entity Print**
(`/admin/config/content/entityprint`, route `entity_print.settings`).

- Settings form + per-engine config (paper size, download, CSS) → [configure/settings.md](configure/settings.md)
- Enable the "View PDF" link / block / bulk action on an entity → [configure/display-links.md](configure/display-links.md)
- Render / save / stream documents in code → [api/print-builder.md](api/print-builder.md)
- Add a new print engine (plugin) → [plugins/print-engine.md](plugins/print-engine.md)
- Alter CSS / HTML / filename / config (events) → [extend/events.md](extend/events.md)
- Permissions (static + per entity type/bundle) → [permissions/permissions.md](permissions/permissions.md)
- Print template & theming → [theming/templates.md](theming/templates.md)

Submodule `entity_print_views` (printing Views) is documented separately.
