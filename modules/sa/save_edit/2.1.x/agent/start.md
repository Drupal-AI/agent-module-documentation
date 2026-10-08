# Save & Edit — agent index

Adds a "Save & Edit" action to node add/edit forms that saves and redirects back to the
**edit form** (route `<entity>.edit-form`) instead of the default post-save page, with optional
auto-unpublish and default-button hiding/relabeling. Pure `hook_form_alter` + config; no
entities, plugins, or Drush.

- **All settings keys, per-content-type enablement, and permissions** →
  [configure/settings.md](configure/settings.md)
- **The form-alter mechanism (button cloning, submit handlers, redirect)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object: `save_edit.settings`. Configure route `save_edit.save_edit_settings_form`
  at `/admin/config/save_edit/settings`.
- A content type is enabled when `node_types.<bundle>` equals `<bundle>` (a "0" value = off).
- Button only appears for users with permission `use save and edit`.
- Permissions: `use save and edit`, `administer save and edit`.
