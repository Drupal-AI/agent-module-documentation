# Layout builder extras — agent index

Opt-in UI/UX tweaks for core Layout Builder. Depends on `layout_builder`. All features are OFF by
default and toggled on one settings form. Adds no content model, no Drush. Provides one permission and
a config schema. Headline feature: swap an existing section's layout in place while keeping its blocks.

- **Settings form, every toggle, config keys, the layout-swap flow, custom routes** →
  [configure/settings.md](configure/settings.md)
- **Permission model + how it relates to core Layout Builder access (does NOT widen editing access)** →
  [permissions/permissions.md](permissions/permissions.md)
- **`hook_layoutbuilder_extras_allowed_layouts_alter()` — filter the "Change layout" list** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Config object `layoutbuilder_extras.settings`; form route `layoutbuilder_extras.settings_form` at
  `/admin/config/content/layout-builder-extras-settings` (perm `manage layoutbuilder_extras settings`).
- Custom routes `layoutbuilder_extras.alter_section` and `layoutbuilder_extras.section_actions` are
  both gated by `_layout_builder_access: 'view'` — the same check core uses for its section routes.
- Optional `section_library` module: when present, its picker is merged into the section-actions dialog.
