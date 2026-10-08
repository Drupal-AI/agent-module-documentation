<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scanning

## UI
- Report: `/admin/reports/project-health-inspector` (perm `access project health inspector report`).
- Markdown export: `/admin/reports/project-health-inspector/markdown`; also `/summary`, `/history`, `/help`.
- Config: `/admin/config/development/project-health-inspector` (`ProjectHealthInspectorSettingsForm`, perm `administer project health inspector`) — scan scopes, checks, history storage.

## Drush
- `drush project-health-inspector:scan` (alias `drush phi:scan`) runs the same scan headless.

## Scanned locations
`modules/contrib`, `modules/custom`, `profiles/*/modules`, `sites/*/modules`.

## Check families (heuristic, with confidence levels)
Missing `configure:` vs an admin route; unparseable/mis-typed `config/install/*.yml`; config keys absent from schema;
route form/controller classes referencing missing files; probable missing `drupal:file`/`drupal:media` deps. Each finding
becomes issue-draft fields via `IssueMarkdownBuilder`.
