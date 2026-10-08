# entity_browser — agent start

Framework for configurable entity pickers. Each **browser** is a config entity
(`entity_browser.browser.*`) built from pluggable parts. Admin UI:
**Admin → Config → Content → Entity browsers** (`/admin/config/content/entity_browser`,
route `entity.entity_browser.collection`). No core module deps; submodules add IEF + examples.

- Create/configure a browser (widgets, selector, display, selection) → [configure/browsers.md](configure/browsers.md)
- Attach a browser to a field (entity_reference_browser / file_browser widgets) → [configure/field-widgets.md](configure/field-widgets.md)
- The six plugin types it defines + how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Use the `entity_browser` render/form element in code → [api/element.md](api/element.md)
- Alter hooks for plugin definitions & forms → [hooks/hooks.md](hooks/hooks.md)
- Permissions (admin + per-browser access) → [permissions/permissions.md](permissions/permissions.md)
