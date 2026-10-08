# Quick Tabs jQuery UI (quicktabs_jqueryui) 4.3.x — agent index

Submodule of **quicktabs**. Adds a single TabRenderer plugin so a
`quicktabs_instance` can render with the jQuery UI Tabs widget.

- Renderer plugin id: `ui_tabs` (`Drupal\quicktabs_jqueryui\Plugin\TabRenderer\UiTabs`, extends `TabRendererBase`), registered with the parent's `plugin.manager.tab_renderer`.
- Requires modules `block` and `jquery_ui_tabs`; loads library `quicktabs.ui` (js/qt_ui_tabs.js + jquery_ui_tabs/tabs).
- No own config entity, permission, config schema, or Drush command; the renderer has no extra schema options. Configure via the parent UI: Structure » Quick Tabs (`/admin/structure/quicktabs`), pick renderer "jquery ui".
- Parent module plugin/config details: [../../../../4.3.x/agent/plugins/plugin-types.md](../../../../4.3.x/agent/plugins/plugin-types.md), [../../../../4.3.x/agent/configure/tab-instances.md](../../../../4.3.x/agent/configure/tab-instances.md).
