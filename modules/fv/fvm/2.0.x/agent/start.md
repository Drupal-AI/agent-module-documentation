# Field View Mode (fvm) — agent index

Adds a locked `view_mode_selection` entity-reference field so editors pick a per-entity view mode.
Enabled per bundle from one settings form. Depends on `field_ui`. No permission of its own
(the form uses core `administer display modes`), no config schema, no Drush.

- **Settings form, what it creates/deletes, view-mode limiting, Layout Builder handling, the
  select widget & selection plugin, the view-mode switch hook** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI: `/admin/structure/display-modes/view/fvm` (route `fvm.settings_form`, perm
  `administer display modes`). Config object: `fvm.settings` (raw keys `entity__bundle`,
  `entity__bundle__view_modes`, `hide_layout_builder_field`).
- Field: locked `entity_reference` `view_mode_selection` → target `entity_view_mode`, on the default
  form display of each enabled bundle.
- Widget `fvm_options_select` (extends core `OptionsSelectWidget`); selection plugin `field_view_mode`.
- `hook_entity_view_mode_alter()` applies the chosen view mode at render time.
