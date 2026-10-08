# Settings form, Ace editor and config

## Settings form

- Route: `inline_formatter_field.settings_form` → path `/admin/config/inline_formatter_field/settings`
  (`_admin_route: TRUE`), menu link under `system.admin_config_content`.
- Form: `Drupal\inline_formatter_field\Form\SettingsForm` (form id
  `inline_formatter_field_settings_form`), extends `ConfigFormBase`.
- Access: permission `edit inline formatter field settings` (`restrict access: true`).
- Editable config: `inline_formatter_field.settings`.

The form edits the **module defaults** used when creating/seeding the Ace editor experience:

| Field | Config key | Meaning |
|---|---|---|
| Ace Editor source | `ace_source` | URL (`http://`/`https://`) or Drupal-root-relative path to `ace.js`. Default `https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ace.js`. |
| Default editor | `default_editor` | Machine name of the `editor` entity IFF uses for its `text_format` fields (default `iff_ace_editor`). |
| Themes table | `available_themes` + `ace_theme` | Key→label list of Ace themes and the default one. |
| Modes table | `available_modes` + `ace_mode` | Key→label list of Ace modes and the default one (default `ace/mode/twig`). |
| Extra options | `extra_options` | Key→value Ace `EditorOptions` (e.g. `wrap: "true"`, `showPrintMargin: "true"`). |

The themes/modes/extras tables are AJAX add/remove/reorder/"make default" (`::addTheme`,
`::removeTheme`, `::makeDefaultTheme`, `::reloadThemeForm`, and the mode/extra equivalents). Values
are gathered by static `getThemes`/`getModes`/`getExtras` (weight-sorted).

`validateForm()` rejects an `ace_source` that is neither `http(s)://` nor an existing file under
`DRUPAL_ROOT` (`file_exists(DRUPAL_ROOT . $ace_source)`).

`hook_library_info_alter` (`inline_formatter_field.module`) injects `ace_source` into the
`inline_formatter_field/ace_editor` library at runtime, choosing `type: external` for `http(s)://`
sources and `type: file` otherwise, and `minified` when the path ends in `.min.js`.

## The `iff_ace_editor` editor plugin

`Plugin/Editor/AceEditor` (`@Editor(id="iff_ace_editor", is_xss_safe = FALSE,
supported_element_types = {"textarea"})`). It attaches library `inline_formatter_field/iff_ace_editor`
and passes its settings to JS via `getJsSettings()`. Its `buildConfigurationForm` is the
per-editor version of the same themes/modes/extras tables, plus:

- `clear_tokens` (checkbox) — "Remove tokens from the final text if no replacement value can be
  generated." Stored in `editor.settings.iff_ace_editor:clear_tokens` (default `FALSE`) and read by
  every render path as the `clear` option to `token->replace`.

Because it is a normal core `editor`, you can point IFF at any other editor (e.g. CKEditor 5) by
changing `default_editor`, or attach `iff_ace_editor` to other text formats. Install seeds a filter
format `iff_ace_editor` (empty `filters: {}`) and the editor entity (config in
`config/install/`).

## AJAX helper route (Manage-display UI only)

- Route: `inline_formatter_field.ajax.settings` → `/inline-formatter-field/ajax`, controller
  `InlineFormatterFieldAjaxController::render`, permission `edit inline formatter field formats`.
- POST body carries `element` (a DOM selector) and `settings` (the current Ace theme/mode/extras).
  The controller returns an `AjaxResponse` that injects a per-user "Ace Editor Options" details form
  (theme/mode/extra selects) before the element, and — when the `token` module is installed — a
  `token_tree_link` (`#token_types => 'all'`) after it. Per-user choices are persisted client-side as
  a cookie (see README), not in config.

## Config objects / schema summary

- `inline_formatter_field.settings` — module defaults (keys above).
- `editor.settings.iff_ace_editor` — per-editor `default_theme`, `default_mode`, `available_themes`,
  `available_modes`, `available_extras`, `clear_tokens`.
- `field.formatter.settings.inline_formatter_field_formatter` — the per-display template
  (`formatted_field.value`, `formatted_field.format`).
- `field.value.inline_formatter_field` — the stored `display_format` boolean.
