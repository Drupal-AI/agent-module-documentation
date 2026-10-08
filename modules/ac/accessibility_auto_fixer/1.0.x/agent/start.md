<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessibility Auto Fixer (accessibility_auto_fixer) — agent index

WCAG AA accessibility scanner for Drupal 10.3/11. Two custom scanners (no external a11y
engine): a client-side JS scanner over the live DOM/computed styles, and a server-side PHP
scanner that fetches a URL and parses HTML with `DOMDocument`. Findings feed an admin
dashboard, a per-scan details page, one-click persistent DOM auto-fixes, and Drush/CI commands.

- Machine name: `accessibility_auto_fixer` · package Content · license GPL-2.0-or-later.
- Core: `^10.3 || ^11`. Composer requires only core.
- Dependencies (modules): `node` (adds the per-node scan tab).
- Configure route: `accessibility_auto_fixer.settings` (`/admin/config/development/a11y-settings`).

## Permissions (`accessibility_auto_fixer.permissions.yml`)
- `access accessibility reports` — run scans, view dashboard/reports (NOT `restrict access`).
- `administer accessibility settings` — manage settings (`restrict access: true`).

## Database (`accessibility_auto_fixer.install`, `hook_schema`)
- `a11y_results` — per-page scan rows: path, violations, score, details (JSON), scan_type, created.
- `a11y_fixes` — applied fixes per page (path, issue_id, selector, fixed_at) used to filter re-scans.

## Services (`accessibility_auto_fixer.services.yml`)
- `accessibility_auto_fixer.scanner` → `Service\A11yScannerService` — fetches a URL and scans HTML.
- `accessibility_auto_fixer.storage` → `Service\A11yStorageService` — persists results/fixes, scoring.
- `accessibility_auto_fixer.route_discovery` → `Service\A11yRouteDiscoveryService` — enumerates paths.
- `accessibility_auto_fixer.commands` → `Commands\A11yCommands` — Drush `a11y:scan`, `a11y:scan-all`.

## Routes (`accessibility_auto_fixer.routing.yml`)
- `.dashboard` GET `/admin/reports/a11y-dashboard` — `DashboardController::view`.
- `.scan_logs` GET `/admin/reports/a11y-logs` — `DashboardController::logs`.
- `.details` GET `/admin/reports/a11y-details/{id}` — `ScanDetailsController::view`.
- `.settings` `/admin/config/development/a11y-settings` — `Form\AccessibilitySettingsForm`.
- `.report` POST `/admin/reports/a11y-report` — `ScanController::report` (persist JS results).
- `.scan_server` POST `/admin/reports/a11y-scan-server` — `ScanController::scanServer` (scan a URL).
- `.node_scan` `/node/{node}/a11y-scan` — `NodeScanController::view` (scan tab; custom access).
- `.scan_all_ajax` `/admin/reports/a11y-scan-all` — `ScanController::scanAll` (POST; GET redirects).
- `.fix` POST `/admin/reports/a11y-fix` — `ScanController::fix` (returns a DOM fix payload).
- `.discover_routes` GET `/admin/reports/a11y-discover` — `ScanController::discoverRoutes`.

## Libraries / assets
- `accessibility_auto_fixer/scanner` (`js/scanner.js`) — client scan + report + fix client.
- `accessibility_auto_fixer/dashboard` (`js/ui.js`, `css/dashboard.css`) — panel + dashboard UI.

## Config object `accessibility_auto_fixer.settings`
Keys: enabled, auto_scan, min_score, exclude_roles, enabled_node_types, scan_aria, scan_contrast,
scan_alt, autofix_aria, autofix_alt, fail_on_critical, report_email. No `config/install` or
`config/schema` shipped; defaults come from the form's `?? ...` fallbacks.

## Solution docs
- [Settings & configuration](config/settings.md)
- [Scanning API, endpoints & Drush](api/scanning.md)
