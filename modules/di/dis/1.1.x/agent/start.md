<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deployment identifier status (dis) — agent index

A tiny utility module that adds one **status-report warning** when Drupal's `deployment_identifier`
setting is not configured. Package `Utility`. **No dependencies** beyond Drupal core. Core
requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- **The requirements hook, what triggers the warning, and how to set the identifier** →
  [operations/status-report.md](operations/status-report.md)

## What it actually is

- A single file, `dis.install` — no `src/`, no routes, no services, no permissions, no config, no
  schema, no Drush, no submodules, no libraries.
- `dis_requirements($phase)` — in the `runtime` phase, reads `Settings::get('deployment_identifier')`.
  When it is `NULL`, returns a `REQUIREMENT_WARNING` row (title "Deployment identifier", value
  "Not set") on `/admin/reports/status`. Any non-null value → no warning.
- `dis_install()` / `dis_uninstall()` — each add one `messenger()` status message; the install
  message links to `system.status`.

## Operate it

- The module has no settings. To clear the warning, set `$settings['deployment_identifier']` in
  `settings.php` (or via deployment tooling) to any non-null value. See
  [operations/status-report.md](operations/status-report.md).
