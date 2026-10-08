<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Health Inspector (project_health_inspector) — agent index
**Scans downloaded modules for reproducible health issues and exports Drupal.org-ready issue drafts.**

- **Version:** 1.0.x  **Core:** ^10.3 || ^11 || ^12
- **Report routes (perm `access project health inspector report`):** report, `/markdown`, `/summary`, `/history`, `/help`.
- **Settings routes (perm `administer project health inspector`, restricted):** `/settings`, admin form `/admin/config/development/project-health-inspector`.
- **Services:** `ProjectHealthScanner`, `ModuleInventory`, `IssueMarkdownBuilder`. **Drush:** `project-health-inspector:scan` / `phi:scan`.
- **Security:** read-only static analysis of on-disk module code; the report (which surfaces project weaknesses) requires `access project health inspector report`, and scan/history config requires the restricted admin permission. No anonymous access, no mutation of scanned modules. Sound.

See [drush/scan.md](drush/scan.md)
