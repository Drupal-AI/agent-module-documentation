<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Formatter Field (inline_formatter_field) — agent index

Adds a field type whose only stored data is a **boolean checkbox**; when checked, the entity's
display renders an **admin-authored HTML/Twig template** attached to the field's formatter (in
*Manage display*). The template is authored in an **Ace code editor** (a bundled `editor` plugin
`iff_ace_editor` + a filter format of the same name), and at view time it is run through
`processed_text` (the chosen filter format) → **Drupal token replacement** → a **Twig
`inline_template`**. The Twig context exposes the host entity under its entity-type key (`node`,
`media`, `block_content`, …) and the current user as `current_user`; tokens like `[node:title]`
also work. Two submodules reuse the same render pipeline: `inline_formatter_display` replaces a whole
entity view display with such a template (third-party setting on the view display), and
`inline_formatter_views_field` adds a Views "Inline Formatter" global field.

The field type's formatter (`inline_formatter_field_formatter`) is also declared for the core
`boolean` field type, so the same template mechanism can be attached to any existing boolean field.
The default template is `<h1>Hello World!</h1>`.

- Depends on: `drupal:field`, `drupal:editor`, `drupal:filter` (all core). Views submodule adds
  `drupal:views`.
- Core (source `.info.yml`): `^9.2 || ^10 || ^11`. Package: `field types`.
- **Has a settings page**: route `inline_formatter_field.settings_form` at
  `/admin/config/inline_formatter_field/settings` (`configure` in info.yml). Provides config schema.
  **Provides permissions** (4 across module + submodules). No services of its own, no drush, defines
  **no new plugin types** (it registers a core `Editor` plugin instance, not a manager).

## What you'd do → where

- **Attach the field / write the template, understand what renders and the Twig context** →
  [fields/formatter.md](fields/formatter.md)
- **Configure the Ace editor, the source URL, themes/modes/extras, `clear_tokens`, the AJAX helper** →
  [configure/settings.md](configure/settings.md)
- **Override a whole entity view display with a template (`inline_formatter_display`)** →
  [configure/display.md](configure/display.md)
- **Add a templated field to a View (`inline_formatter_views_field`)** →
  [views/views-field.md](views/views-field.md)
- **Who may author templates / change settings** → [permissions/permissions.md](permissions/permissions.md)
- **Inject extra variables into the Twig context from a custom module** → [hooks/context.md](hooks/context.md)

## Key facts (real machine names)

- Field type: `inline_formatter_field` (label "Inline Formatter", category "Formatting", class
  `InlineFormatterFieldType`). One storage column `display_format` (int tiny, boolean); `isEmpty()`
  ⇒ empty unless `display_format == 1`.
- Widget: `inline_formatter_field_widget` (`InlineFormatterFieldWidget`) — a single checkbox
  "Render the format for &lt;field label&gt;".
- Formatter: `inline_formatter_field_formatter` (`InlineFormatterFieldFormatter`), declared for field
  types `inline_formatter_field` **and** `boolean`. Setting: `formatted_field` = `{value, format}`
  (was a bare string before v4; migration handled in code and `update_8005`).
- Editor plugin: `iff_ace_editor` (`Plugin/Editor/AceEditor`, `is_xss_safe = FALSE`). Install creates
  filter format `iff_ace_editor` and editor `iff_ace_editor`.
- Routes: `inline_formatter_field.settings_form` (`/admin/config/inline_formatter_field/settings`,
  form `SettingsForm`, perm `edit inline formatter field settings`);
  `inline_formatter_field.ajax.settings` (`/inline-formatter-field/ajax`, controller
  `InlineFormatterFieldAjaxController::render`, perm `edit inline formatter field formats`) — returns
  the per-user Ace options + optional token-tree link for the Manage-display UI.
- Config object `inline_formatter_field.settings`: `default_editor`, `ace_source`, `ace_theme`,
  `ace_mode`, `available_themes`, `available_modes`, `extra_options`. Editor settings schema
  `editor.settings.iff_ace_editor`: `default_theme`, `default_mode`, `available_themes`,
  `available_modes`, `available_extras`, `clear_tokens`.
- Formatter config schema: `field.formatter.settings.inline_formatter_field_formatter`
  (`formatted_field.value`, `formatted_field.format`).
- Permissions: `edit inline formatter field formats`, `edit inline formatter field settings`
  (base, both `restrict access: true`); `edit inline formatter display formats` (display submodule);
  `edit inline formatter views field` (views submodule).
- Libraries: `inline_formatter_field/ace_editor` (JS filled at runtime from `ace_source` by
  `hook_library_info_alter`), `inline_formatter_field/iff_ace_editor` (editor JS/CSS),
  `inline_formatter_display/display_form` (Manage-display toggle JS).
- Hooks implemented: base — `hook_help`, `hook_library_info_alter`. Display submodule — `hook_help`,
  `hook_form_entity_view_display_edit_form_alter`, `hook_entity_view_alter`,
  plus submit callback `inline_formatter_display_save`. Views submodule — `hook_views_data`.
- Integrator alter hooks: `hook_inline_formatter_field_formatter_context_alter(&$context, $entity)`,
  `hook_inline_formatter_display_context_alter(&$context, $entity)`,
  `hook_inline_formatter_views_field_context_alter(&$context)`.
- Submodules: `inline_formatter_display` (third-party settings `use`, `formatted_display` on
  `core.entity_view_display.*`); `inline_formatter_views_field` (Views field id
  `inline_formatter_views_field`, views-data key `inline_formatter` in the "Global" group).
- Update hooks: `inline_formatter_field_update_8001`–`8005` (config restructuring, `\r\n`
  normalization, permission-name fix, v4 editor/filter creation + string→`{value,format}` migration).
