<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Project Health Inspector scans the Drupal modules downloaded on a site for deterministic, reproducible project-health issues and prepares Drupal.org-ready issue drafts, so contributors can file well-formed bugs without hand-collecting every code reference.

---

It is not a PHPCS/PHPStan/Rector/Upgrade-Status/AI replacement; it targets Drupal-specific problems affecting installability, administration, config validation or route execution. `ProjectHealthScanner` (with `ModuleInventory`) inspects modules under `modules/contrib`, `modules/custom`, `profiles/*/modules` and `sites/*/modules`, running checks such as: a missing `configure:` key when a settings/admin route exists; malformed or wrongly-typed `config/install/*.yml`; installed config keys missing from the schema mapping; route form/controller classes pointing to missing files; and likely-missing `drupal:file`/`drupal:media` dependencies. `IssueMarkdownBuilder` renders each finding into issue fields (severity, confidence, reproduction, actual/expected, code references, proposed resolution). The report and its markdown/summary/history views require `access project health inspector report`; scan-scope and history settings require the restricted `administer project health inspector`. A Drush command (`project-health-inspector:scan` / `phi:scan`) runs the same scan headless.

Set up by enabling the module, optionally tuning scan scopes at the admin settings route, and viewing findings at `/admin/reports/project-health-inspector` or exporting markdown.

---
- Scan all downloaded contrib/custom modules for health issues.
- Export a Drupal.org-ready issue draft as Markdown.
- Detect a missing `configure:` key on modules with a settings route.
- Catch malformed `config/install/*.yml` that Drupal cannot parse.
- Flag install config that parses as a list/scalar instead of a mapping.
- Find installed config keys missing from the config schema.
- Detect route classes pointing at missing module files.
- Spot likely-missing `drupal:file` or `drupal:media` dependencies.
- Run the scan headless via `drush phi:scan`.
- View a summary of findings by severity/confidence.
- Keep a scan history for trend review.
- Read the built-in help/checks documentation.
- Prepare reproduction steps automatically per finding.
- Restrict scan configuration to `administer project health inspector`.
- Grant read/export to `access project health inspector report`.
- Prioritize contributions by scanning many modules at once.
- Generate code references without manual grepping.
- Validate a module before releasing it.
- Batch-triage a site's contrib tree health.
