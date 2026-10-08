Quick Tabs Accordion is a submodule of Quick Tabs that adds an `accordion_tabs` renderer, so a Quick Tabs instance can display its tabs as a jQuery UI accordion instead of horizontal tabs.

---

Enabling this submodule registers one extra TabRenderer plugin (`accordion_tabs`, `Drupal\quicktabs_accordion\Plugin\TabRenderer\AccordionTabs`) with the parent module's `plugin.manager.tab_renderer`. On a `quicktabs_instance` you then choose "accordion" as the renderer; each tab becomes a collapsible accordion section powered by the core-provided `jquery_ui_accordion` library (js/qt_accordion.js). It requires the `block` and `jquery_ui_accordion` modules. Renderer options (schema `quicktabs.options.accordion_tabs`, defined in the parent's config schema) are `collapsible` (allow all sections closed) and `heightStyle` (`auto`, `fill`, or `content`). It adds no config entity, permission, or Drush command of its own; all configuration happens in the parent Quick Tabs admin UI at Structure » Quick Tabs.

---

- Present a Quick Tabs instance as a vertical jQuery UI accordion.
- Build FAQ-style collapsible sections, one question per accordion panel.
- Allow all accordion panels to be collapsed at once via the `collapsible` option.
- Control panel sizing with `heightStyle` (`auto`, `fill`, or `content`).
- Show the same node/block/View tab content as accordion panels instead of tabs.
- Offer a mobile-friendly stacked alternative to horizontal tabs.
- Switch an existing tab set from tabs to accordion by changing only its renderer.
- Group long documentation sections into expandable panels on one page.
- Combine accordion panels that each load a different View.
- Use the accordion renderer inside a placed Quick Tabs block in any region.
- Reuse the parent module's tab types (node, block, view, qtabs) with accordion display.
- Provide a compact way to browse many content items without long scrolling.
- Render step-by-step guides where each step is a collapsible section.
- Keep only one panel open at a time for focused reading.
- Theme accordion output via the standard jQuery UI accordion markup.
