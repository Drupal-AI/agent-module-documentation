# Hooks & integration points

IMCE ships no `imce.api.php`. Its extension surface is the ImcePlugin interface plus a few
core hooks it implements and one alter it invokes.

## Alter hook it invokes
- `hook_imce_plugin_info_alter(array &$definitions)` — modify/remove discovered ImcePlugin
  definitions (invoked by `ImcePluginManager`, cache id `imce_plugins`).

## Core hooks IMCE implements (for reference / integration)
- `hook_theme()` → `imce_page`, `imce_help` (see [../theming/theming.md](../theming/theming.md)).
- `hook_file_download()` → grants access to files under Imce control (`Imce::accessFileUri`).
- `hook_field_widget_third_party_settings_form()` / `..._settings_summary_alter()` /
  `hook_field_widget_single_element_form_alter()` → add an **"Enable Imce"** third-party
  setting to file/image field widgets and attach the browser to enabled widgets.
- `hook_form_editor_link_dialog_alter()` / `hook_form_editor_image_dialog_alter()` →
  inject the Imce browser (`data-imce-type` = link/image) into text-editor dialogs.
- `hook_editor_js_settings_alter()` / `hook_form_filter_format_form_alter()` → wire the
  CKEditor 5 selector plugin and drop it when the user lacks Imce access.

## Enabling Imce on a file field widget (config)
```yaml
# field.widget third-party settings
third_party_settings:
  imce:
    enabled: true
```

To add operations/permissions of your own, implement an ImcePlugin rather than a hook —
see [../plugins/imce-plugin.md](../plugins/imce-plugin.md).
