# entity_browser — agent start

Framework for configurable entity pickers. Each **browser** is a config entity
(`entity_browser.browser.*`) built from pluggable parts. Admin UI:
**Admin → Config → Content → Entity browsers** (`/admin/config/content/entity_browser`,
route `entity.entity_browser.collection`). No core module deps; submodules add IEF + examples.
Runs on Drupal 10.3 / 11 / 12.

Since 2.16/2.17 all plugins are declared with **PHP attributes** (`src/Attribute/*`,
`#[EntityBrowserWidget(...)]` etc.; the old `src/Annotation/*` classes stay for BC), field
widgets use `#[FieldWidget]`, and procedural hooks moved to OOP hook classes in
`src/Hook/` (`#[Hook(...)]`, autowired in `entity_browser.services.yml`).

- Create/configure a browser (widgets, selector, display, selection) → [configure/browsers.md](configure/browsers.md)
- Attach a browser to a field (entity_browser_entity_reference / entity_browser_file widgets) → [configure/field-widgets.md](configure/field-widgets.md)
- The six plugin types it defines + how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Use the `entity_browser` render/form element in code → [api/element.md](api/element.md)
- Alter hooks for plugin definitions & forms → [hooks/hooks.md](hooks/hooks.md)
- Permissions (admin + per-browser access) → [permissions/permissions.md](permissions/permissions.md)
