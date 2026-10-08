# Multiselect — agent index

A two-box "Available / Selected" multi-selection **field widget** plus a matching
`#type => 'multiselect'` Form API element. Widget id `multiselect`, extends core
`OptionsWidgetBase`. Depends on `options`. One global setting (box width). No permissions,
no Drush, no plugin type to implement.

- **Attach the widget to a field; the single global width setting** →
  [configure/widget.md](configure/widget.md)
- **Use `#type => 'multiselect'` in a custom Form API form; the render element & theming** →
  [api/form-element.md](api/form-element.md)

Key facts:
- Widget id `multiselect`; supported field types: `list_string`, `list_float`, `list_integer`, `entity_reference` (`multiple_values = TRUE`).
- Global config object `multiselect.settings`, key `multiselect.widths` (integer px, default `250`); admin form route `multiselect.admin_settings` at `/admin/config/content/multiselect`.
- Set the widget on an entity via **Manage form display** — component `type: multiselect`.
- Front-end library `multiselect/drupal.multiselect`; template `multiselect.html.twig`.
