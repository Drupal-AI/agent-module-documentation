<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Status Report (custom_status_report) — agent index

Customizes the core **Status Report** page (`/admin/reports/status`), specifically its
**General System Information** section: hide/show default cards (Drupal, web server, cron, PHP,
database), reorder them by weight, and surface cards contributed by other modules. Package
`Administration`. **No dependencies outside core.** Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.0.

- **Settings form, the config object, how cards are filtered/ordered, and the extension hook for
  other modules** → [config/settings.md](config/settings.md)

## What it actually is

- **No new entity, field, plugin type, permission, service, or Drush command.** It works purely
  through four hooks in `custom_status_report.module` plus one settings form and one render-element
  subclass.
- **Config object** `custom_status_report.settings` (default in
  `config/install/custom_status_report.settings.yml`): two maps keyed by card id —
  `card_visibility` (0/1) and `card_weight` (int). Default cards: `drupal`, `webserver`, `cron`,
  `php`, `database_system`, plus `custom_status_report`'s own card. **No `config/schema/`** ships.
- **Route** `custom_status_report.settings` → `/admin/config/system/custom-status-report`, a
  `_form` route requiring **`administer site configuration`** (core permission — the module
  defines none of its own). Menu link under `system.admin_config_system`.
- **Form** `CustomStatusReportSettingsForm` (`src/Form/…`, `getFormId()` =
  `custom_status_report_settings`), a `ConfigFormBase` editing `custom_status_report.settings`.
  Draggable table of checkboxes + weights. Injects `module_handler` and `extension.list.module`.
- **Render element** `CustomStatusReportPage` (`src/Element/…`) extends core
  `\Drupal\system\Element\StatusReportPage`; `hook_element_info_alter()` re-points core's
  `status_report_page` `#pre_render` `preRenderGeneralInfo` callback to it. It filters hidden
  cards, appends modules' `add_to_general_info` requirements, and sorts by `card_weight`.
- **Theme override**: `hook_theme_registry_alter()` repoints `status_report_general_info` to the
  module's `templates/status-report-general-info.html.twig` and adds a `cards` variable.
- **`hook_requirements_alter()`** adds the module's own OK card ("Custom Status Report installed…")
  with `add_to_general_info => TRUE` and its `icons/task-list.png`.
- **Library** `custom_status_report/status_overrides` (just `css/custom_status_report.css`),
  attached to the report template and the settings form via `hook_form_alter()`.

See [config/settings.md](config/settings.md) for the full operating detail.
