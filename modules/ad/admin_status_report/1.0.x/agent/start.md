<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin status report (admin_status_report) — agent index

A plugin-based message system: defines an **AdminStatus** plugin type whose enabled plugins push
status/warning/error **messages through Drupal's messenger** on each request. Ships a plugin that
re-displays selected **core status-report** items and one that shows an **admin-defined message**.
Package `custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.8. Marked
**obsolete/unsupported** on drupal.org. No composer.json in the package; no external deps.

- **Plugin type, the two bundled plugins, and the display subscriber** →
  [plugins/admin-status.md](plugins/admin-status.md)
- **Settings form, config object, route & permission** → [config/settings.md](config/settings.md)

## What it provides

- **Plugin type** `AdminStatus` — manager service `plugin.manager.admin_status_report`
  (`src/AdminStatusPluginManager.php`), discovery dir `Plugin/AdminStatus`, interface
  `AdminStatusInterface`, annotation `@Plugin`, base class `AdminStatusPluginBase`.
- **Bundled plugins** (`src/Plugin/AdminStatus/`):
  - `CoreStatusReport` (id `core_status_report`) — renders chosen error/warning items from
    `system.manager`'s `listRequirements()` via the `status_report` theme.
  - `DefaultMsg` (id `default_message`) — one admin-entered message + severity.
- **Route** `admin_status_report.admin_status_form` → `/admin/config/system/admin_status_report`
  (`Form\AdminStatusReportForm`, permission **`administer admin status report`**); also a
  Config→System menu link and `configure` in info.yml.
- **Permission** `administer admin status report` (`.permissions.yml`).
- **Config object** `admin_status_report.settings`, key `plugin_status` (per-plugin
  `{enabled, config}`). **No config schema file ships.**
- **Event subscriber** `AdminStatusEventSubscriber` (service `admin_status_report.eventsubscriber`,
  `src/EventSubscriber/AdminStatusEventSubscriber.php`) on `kernel.request`.
- `hook_help()` for `help.page.admin_status` in the `.module`.

## Mechanism (from source)

- The admin form (`AdminStatusReportForm`, a `ConfigFormBase`) enumerates all plugin definitions,
  builds an enable checkbox + each plugin's `configForm()` sub-form per plugin, and saves the result
  under `plugin_status` in `admin_status_report.settings`.
- On **every** `kernel.request`, `AdminStatusEventSubscriber::kernelRequest()` loads
  `plugin_status`, and for each **enabled** plugin instantiates it, calls `message($configValues)`,
  render-flattens array messages with `renderer->renderPlain()`, and
  `messenger->addMessage($text, $status)`.
- `CoreStatusReport::message()` calls `system.manager` `listRequirements()`, keeps items whose
  `severity` matches the admin-selected error/warning set, and renders each through
  `#theme => 'status_report'`.
