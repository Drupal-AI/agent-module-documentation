# paragraphs — agent start

Structured, fielded, revisionable content components ("Paragraphs types") that editors add,
nest, reorder, and drag-drop inside an Entity Reference Revisions field. Depends on
`entity_reference_revisions` + core `file`. Types UI: **Admin → Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`, route `entity.paragraphs_type.collection`); global
settings at `/admin/config/content/paragraphs`.

- Create/manage paragraph types + behavior plugins → [configure/types.md](configure/types.md)
- Field widget settings (edit/add modes, features, drag-drop) → [configure/widget.md](configure/widget.md)
- Global settings + `paragraphs.settings` config → [configure/settings.md](configure/settings.md)
- Add non-field functionality with a behavior plugin → [plugins/behavior.md](plugins/behavior.md)
- Convert a paragraph into other types (conversion plugin) → [plugins/conversion.md](plugins/conversion.md)
- Entity/service API for building paragraphs in code → [api/api.md](api/api.md)
- Alter hooks (`paragraphs.api.php`) → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Templates, theme hooks, view modes → [theming/theming.md](theming/theming.md)
