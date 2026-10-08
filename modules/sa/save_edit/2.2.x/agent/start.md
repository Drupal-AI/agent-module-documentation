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
- Node-only: it alters `\Drupal\node\Form\NodeForm` (and pre-11.2 `\Drupal\node\NodeForm`);
  no support for other entity types.

Branch/version: **2.2.x** (2.2.1), `core_version_requirement: ^10 || ^11`. For Drupal 11.2 /
Drupal 12 the project's 3.x branch is intended instead.

## Diff 2.1.x → 2.2.x

Same core mechanism (single `hook_form_alter` + `save_edit.settings` config). Observable changes
in this branch vs the 2.1.x documentation:

- **Version/branch:** `2.2.1` on the `2.2.x` branch (was `2.1.x`); still `^10 || ^11`. The README
  now directs Drupal 11.2 / Drupal 12 sites to the separate 3.x branch.
- **`hide_default_publish` removed:** the Publish-button toggle is gone from the config schema,
  the settings form, and `save_edit_form_alter()`; `save_edit_update_8104()` clears any stale
  value. Remaining hide toggles are `hide_default_save`, `hide_default_preview`,
  `hide_default_delete`. (`save_button_text` remains for relabeling the default Save button.)
- **Redirect robustness:** `save_edit_form_submit_redirect()` now converts the edit-form redirect
  into an explicit HTTP 303 `RedirectResponse` when another submit handler already set a response
  (while leaving AJAX/HTMX-disabled, programmed, and rebuilding forms alone), so Save & Edit
  reliably returns to the edit form. The redirect target stays the current entity's internal
  `edit-form` route.
- **Drupal 12 guard:** the pre-11.2 `\Drupal\node\NodeForm` class is referenced only behind a
  `class_exists()` check, so form_alter is safe where that class has been removed.
- **Test coverage:** the branch ships kernel tests (`tests/src/Kernel/*`) for the form alter,
  redirect, and settings-form access.
