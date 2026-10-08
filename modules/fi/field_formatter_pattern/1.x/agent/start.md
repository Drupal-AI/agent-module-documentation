<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Formatter pattern (field_formatter_pattern) — agent index

Adds an **HTML5 `pattern` (regex) attribute + a custom error message** to core **text edit
widgets**, configured per field on **Manage form display**. Package `Fields`. Version 1.0.3
(doc dir `1.x`). Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. **No dependencies, no
permissions of its own, no routes, no Drush.**

- **What it does, the settings, the widgets it targets, and the extension hook** →
  [fields/widget-pattern.md](fields/widget-pattern.md)

## What it actually is (from source)

- **Not a display formatter** despite the name. It provides two **third-party widget settings**
  on the entity **edit form**, and it never touches field display/output.
- Implemented entirely as hooks in `src/Hook/FieldFormatterPatternHooks.php` (dispatched from
  `field_formatter_pattern.module` via `#[LegacyHook]` wrappers):
  - `hook_field_widget_third_party_settings_form` → adds **Pattern** and **Pattern error
    message** textfields to the widget's settings (gear on Manage form display).
  - `hook_field_widget_form_alter` → copies the pattern onto `$element['value']['#attributes']
    ['pattern']` and the message onto `['#attributes']['title']` (HTML5 client-side validation).
  - `hook_field_widget_settings_summary_alter` → appends `Pattern: @pattern` to the summary line.
  - `hook_help` → the module's help text.
- **Service** `field_formatter_pattern.widget_settings` = `WidgetSettings`
  (`src/WidgetSettings.php`, implements `WidgetSettingsInterface`): `getAllowedSettingsForAll()` /
  `getAllowedSettings($widget_plugin_id)` list which widgets may carry a pattern.
- **Eligible widgets** (hardcoded): `string_textfield`, `string_textarea`, `text_textfield`,
  `text_textarea`, `text_textarea_with_summary`, `key_value_textarea`. Other modules add more via
  **`hook_field_formatter_pattern_widget_settings()`** (see `field_formatter_pattern.api.php`).
- **Config**: stored as form-display third-party settings under the `field_formatter_pattern`
  namespace (keys `pattern`, `pattern_error_message`); schema
  `field.widget.third_party.field_formatter_pattern` in `config/schema/`.
