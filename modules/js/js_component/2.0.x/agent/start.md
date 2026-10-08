<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JS Component — agent index

Register a JS/React (or Twig-wrapped) front-end component from a module or theme via a
`*.js_component.yml` file; each becomes a placeable block that mounts the component and passes
settings/data via `drupalSettings` or `data-*` attributes. No global config page (`configure`
null), no permissions, no Drush. Defines one plugin type: `js_component` (manager
`plugin.manager.js_component`, YAML-discovered across modules + enabled themes).

- **Define a component (the `*.js_component.yml` schema: every key — `label`, `root_id`,
  `libraries`, `settings`, `settings_scope`, `settings_allow_token`, `template`, `handlers`)** →
  [configure/component-definition.md](configure/component-definition.md)
- **Server-side handlers & runtime (block, data providers, form handler classes, the
  build-data event, how settings reach the browser)** → [api/handlers.md](api/handlers.md)
- **Hooks the module invites (`hook_js_component_form_alter`, `_form_submit`, `_info_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Component id = `<provider>.<plugin_id>`; block plugin id = `js_component:<plugin_id>`.
- `settings_scope: dom` (default) → `drupalSettings.jsComponent[<id>][<root_id>]{settings,data}`;
  `attribute` → `data-<key>` on the mount `<div>`.
- A component with a `template:` renders that Twig file (theme hook = component id) instead of an
  inline `<div id="{root_id}">`; the library `js_component/<component_id>` is auto-attached.
- Discovery: `YamlDiscoveryDecorator` over `js_component` files in all module + theme dirs;
  `hook_library_info_build()` builds libraries, `hook_theme()` registers templated components.
