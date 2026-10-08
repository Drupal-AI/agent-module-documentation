# Quick Tabs Accordion (quicktabs_accordion) 4.3.x — agent index

Submodule of **quicktabs**. Adds a single TabRenderer plugin so a
`quicktabs_instance` can render as a jQuery UI accordion.

- Renderer plugin id: `accordion_tabs` (`Drupal\quicktabs_accordion\Plugin\TabRenderer\AccordionTabs`, extends `TabRendererBase`), registered with the parent's `plugin.manager.tab_renderer`.
- Options (schema `quicktabs.options.accordion_tabs`): `collapsible` (bool), `heightStyle` (`auto` | `fill` | `content`).
- Requires modules `block` and `jquery_ui_accordion`; loads library `quicktabs.accordion` (js/qt_accordion.js + jquery_ui_accordion/accordion).
- No own config entity, permission, schema, or Drush command. Configure via the parent UI: Structure » Quick Tabs (`/admin/structure/quicktabs`), pick renderer "accordion".
- Parent module plugin/config details: [../../../../4.3.x/agent/plugins/plugin-types.md](../../../../4.3.x/agent/plugins/plugin-types.md), [../../../../4.3.x/agent/configure/tab-instances.md](../../../../4.3.x/agent/configure/tab-instances.md).
