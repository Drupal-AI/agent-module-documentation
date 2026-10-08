<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group Settings — agent index

Adds one Field Group **form** formatter (`settings`) that renders a group of fields as a
collapsible panel opened by a floating gear icon, with optional per-role visibility. Requires the
`field_group` module (`^3 || ^4`). No global config page (`configure` null), no Drush, no new
plugin types.

- **Adding a Settings field group, the `visible_for_roles` setting, config storage, the render
  element & theme hook** → [configure/field-group.md](configure/field-group.md)
- **The `bypass field_group_settings field visibility` permission and how visibility is enforced**
  → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Plugin: `FieldGroupFormatter` id `settings`, form context only
  (`src/Plugin/field_group/FieldGroupFormatter/Settings.php`), extends field_group's
  `FieldGroupFormatterBase`.
- Visibility is a real render `#access` check (`isVisible()` in the plugin), not just CSS —
  hidden groups are not rendered for disallowed roles.
- Setting `visible_for_roles` (schema
  `field_group_settings.field_group_formatter_plugin.settings`) stored in the
  `core.entity_form_display.*` field-group config.
- Render element `#type` `field_group_settings` (`src/Element/Settings.php`); theme hook
  `field_group_settings` → `templates/field-group-settings.html.twig` (+ `theme.inc`); toggle in
  `js/toggle.js`, styles in `css/settings.css`.
