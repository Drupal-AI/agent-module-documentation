# Custom Menu Links Visibility — agent index

Attaches core Condition plugins to individual `menu_link_content` links to show/hide them in
the rendered menu tree. Depends on `menu_link_content`. No admin page (`configure` null), no
permissions, no Drush, no config schema, no new plugin types.

- **The `visibility` field + condition-plugin widget, the tree-manipulator override, evaluation
  logic, caching, and the display-only-vs-access caveat** →
  [configure/visibility.md](configure/visibility.md)

Key facts:
- Adds base field `visibility` to `menu_link_content` (`FieldType` `menu_link_content_visibility`,
  `no_ui`, serialized). Widget = `MenuLinkContentVisibilityWidget` (vertical tabs of Condition plugins).
- Overrides service `menu.default_tree_manipulators` with
  `MenuLinkContentVisibilityLinkTreeManipulator extends DefaultMenuLinkTreeManipulators`.
- Conditions evaluated AND; deny → `AccessResult::forbidden()` → link removed from tree. Skips
  `_menu_admin` routes and non-`MenuLinkContent` links.
- **Display filtering only — NOT page access control.** Hiding a link does not protect its target
  route; enforce real access on the route/entity itself.
