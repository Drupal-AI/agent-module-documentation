# Element Class Formatter — agent index

A set of **field formatters** that add CSS class(es) to the rendered field **element** (the
`<a>`, `<img>`, `<ul>`, label, or wrapper tag), not the field wrapper. Configured per field on
*Manage display*; settings live in the `entity_view_display` config. **No settings page, no
`configure` route, no permissions, no Drush, no services.** Ships a config schema.

- **Every formatter, its field types, its settings keys, and how to set them (UI/drush)** →
  [configure/formatters.md](configure/formatters.md)
- **Reuse the traits to build your own class-adding formatter** → [extend/traits.md](extend/traits.md)
- **Responsive Image submodule** → `../../modules/element_class_formatter_responsive_image/2.1.x/agent/start.md`

Key facts:
- Every formatter adds an **"Element class"** text field (`class`, space-separated), stored in the
  field's component under `content.<field>.settings.class` in
  `core.entity_view_display.<entity>.<bundle>.<mode>`.
- Formatter ids: `link_class`, `link_ally_class`, `link_list_class`, `image_class`,
  `file_link_class`, `email_link_class`, `telephone_link_class`, `entity_reference_label_class`,
  `entity_reference_list_label_class`, `string_list_class`, `list_string_list_class`,
  `wrapper_class` (+ `responsive_image_class` from the submodule).
- Config schema per formatter: `field.formatter.settings.<id>` (e.g.
  `field.formatter.settings.wrapper_class`).
- Class-adding logic lives in traits: `ElementClassTrait`, `ElementLinkClassTrait`,
  `ElementEntityClassTrait`, `ElementListClassTrait`.
