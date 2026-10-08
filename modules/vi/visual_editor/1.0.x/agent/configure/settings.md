<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Visual Editor settings

Form: `\Drupal\visual_editor\Form\SettingsForm` (`visual_editor_settings`).
Route: `visual_editor.settings` at `/admin/config/visual_editor/settings`
(menu link under Configuration » Services, weight 20).
Permission: `administer site configuration`.
Config object: `visual_editor.settings`. No config schema ships with the module.

## Settings (both booleans, both default off/empty)

- **`disable_styles`** — "Disable default Off-Canvas Styles". When on, `hook_library_info_alter()`
  removes every core off-canvas CSS file from `drupal.dialog.off_canvas` (reset.css, base.css,
  button.css, form.css, table.css, etc.). Use it when the site theme fully styles the sidebar and
  core's off-canvas CSS conflicts. The module still loads its own `css/dialog-overrides.css`.
- **`open_load`** — "Open Off-Canvas on page load". When on, the sidebar dialog opens
  automatically when a preview-enabled node view loads (via `drupalSettings.visual_editor.openLoad`
  read by `Drupal.behaviors.visualEditorLoad`). When off, the sidebar is opened by front-end
  interaction / links rather than on load.

## Notes
- There is no bundle/entity-type selector here. Which nodes get the editor is controlled entirely
  by **`decoupled_preview_iframe`'s** `preview_types` setting — `hook_node_view_alter()` only
  attaches the editor for bundles that module has preview-enabled, and only in `default`/`full`
  view modes (skipped on revision and latest-version routes).
- `visual_editor_update_10001()` clears a legacy `wrapper.*` key from this config.
- The editing UI itself uses the standard node **form display**; to change which fields appear in
  the sidebar, configure the `visual_editor` form mode for the node bundle (Manage form display).
