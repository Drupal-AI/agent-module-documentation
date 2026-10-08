# Views Flexbox — agent index

A single Views **style** plugin (`flexbox`) that renders View results as a CSS flexbox
container. Configured per View display in the Views UI; no global config page (`configure`
null), no permissions, no Drush, no plugin types of its own. Depends on core `views`.

- **The `flexbox` style plugin: every option, where settings live, the template/CSS classes, card & link behavior** →
  [configure/style.md](configure/style.md)

Key facts:
- Style plugin id `flexbox`, class `Drupal\views_flexbox\Plugin\views\style\Flexbox` (extends
  `StylePluginBase`, `usesRowPlugin = TRUE`), theme hook `views_view_flexbox`.
- Settings stored in the View config entity under
  `display.*.display_options.style: { type: flexbox, options: {...} }` (schema `views.style.flexbox`).
- Options: `style` (`_none_`/`cards`), `direction`, `justify`, `align_items`, `align_content`,
  `item_class_default`, `item_class_custom`, `link_to_content`, `link_source`.
- Layout comes from CSS libraries `views_flexbox/views_flexbox` (+ `.cards`) attached in preprocess.
