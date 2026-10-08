# Aten Layouts (erl_layouts) — agent index

Submodule of Entity Reference with Layout. Ships column Layout Discovery layouts with
configurable classes/colors. Depends only on `layout_discovery`. No config form, no
permissions, no Drush.

- **The nine layouts, the `ErlLayout` config form, and the manual/select/force class & color
  modes** → [plugins/layouts.md](plugins/layouts.md)

Parent module: [../../../../2.x/agent/start.md](../../../../2.x/agent/start.md)

Key facts:
- Layouts declared in `erl_layouts.layouts.yml`, class `Drupal\erl_layouts\Plugin\Layout\ErlLayout`,
  template `templates/layouts/columns.html.twig`, library `erl_layouts/erl_layouts`.
- Class/color input mode per layout+region is set by
  `erl_layouts_field_widget_third_party_settings_form` on the ERL widget.
