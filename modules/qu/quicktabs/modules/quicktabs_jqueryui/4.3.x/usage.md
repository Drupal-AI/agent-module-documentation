Quick Tabs jQuery UI is a submodule of Quick Tabs that adds a `ui_tabs` renderer, so a Quick Tabs instance can display its tabs using the jQuery UI Tabs widget.

---

Enabling this submodule registers one extra TabRenderer plugin (`ui_tabs`, `Drupal\quicktabs_jqueryui\Plugin\TabRenderer\UiTabs`) with the parent module's `plugin.manager.tab_renderer`. On a `quicktabs_instance` you then choose "jquery ui" as the renderer, and the tabset is rendered and behaved by the core-provided `jquery_ui_tabs` library (js/qt_ui_tabs.js). It requires the `block` and `jquery_ui_tabs` modules. The submodule adds no config entity, permission, config schema, or Drush command of its own; the renderer has no extra options in schema, and all configuration is done through the parent Quick Tabs admin UI at Structure » Quick Tabs.

---

- Render a Quick Tabs instance with the classic jQuery UI Tabs widget look and feel.
- Give tabs the standard jQuery UI theming and keyboard behavior.
- Switch an existing tab set to jQuery UI tabs by changing only its renderer.
- Reuse the parent module's tab types (node, block, view, qtabs) with jQuery UI display.
- Show node content in a jQuery UI tabbed panel.
- Show a block's output in a jQuery UI tab.
- Render a View inside a jQuery UI tab.
- Nest another Quick Tabs instance in a jQuery UI tab via the qtabs tab type.
- Place the jQuery-UI-rendered Quick Tabs block in any theme region.
- Offer a consistent jQuery UI widget style across a site already using jQuery UI.
- Provide an alternative tab style to the base module's classic `quick_tabs` renderer.
- Build a compact multi-panel widget with jQuery UI tab navigation.
- Use jQuery UI tabs where the design system expects that widget's markup.
- Combine several Views, each in its own jQuery UI tab.
- Migrate a Drupal 7 Quicktabs jQuery UI tabset to the Drupal 10/11 renderer.
