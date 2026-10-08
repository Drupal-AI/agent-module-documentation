# Views Role Based Global Text — agent index

Adds **role-based visibility** to the Views *Global: Text area* handler. No settings page, no
permissions, no plugins of its own — it just replaces the core `text` area plugin class with
`RoleBasedGlobalText` (via `hook_views_plugins_area_alter()`), which adds Roles + Negate
options to the text-area config form.

- **Configure which roles see a Global: Text area, the Negate option, where it's stored, and
  the render logic** → [configure/role-visibility.md](configure/role-visibility.md)

Key facts:
- Class `Drupal\views_role_based_global_text\RoleBasedGlobalText extends
  \Drupal\views\Plugin\views\area\Text`.
- Options live in the view's area handler: `roles_fieldset.roles` (checkboxes) and
  `roles_fieldset.negate` (boolean).
- Empty role selection = show to everyone (core behaviour unchanged).
- Depends only on `views`.
