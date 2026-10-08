<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer Entity Browser (dev_entity_browser) — agent index

A single **read-only admin report** that enumerates every content entity type, its bundles, and
each bundle's field structure (type, description, cardinality, list `allowed_values`, reference
`target_bundles`). Package `Development`. No dependencies beyond core (`^10 || ^11`). License
GPL-2.0-or-later. Installed version 1.0.3 (version-dir `1.0.x`). No settings form, no config
storage, no plugins, no Drush.

- **The route, permission, service, controller and how the report is built** →
  [reports/entity-browser.md](reports/entity-browser.md)

## What it actually is

- **One route** `dev_entity_browser.entity_browser` at **`/admin/structure/dev-entity-browser`**
  (`dev_entity_browser.routing.yml`), gated by permission **`view dev entity browser`**
  (`_permission`). Title "Developer Entity Browser".
- **One permission** `view dev entity browser` (`dev_entity_browser.permissions.yml`,
  `restrict access: true`).
- **One controller** `DevEntityBrowserController` (invokable, `__invoke()`) in
  `src/Controller/DevEntityBrowserController.php` — just returns
  `DevEntityBrowser::buildReport()`.
- **One service** `dev_entity_browser.dev_entity_browser` → `Drupal\dev_entity_browser\Service\DevEntityBrowser`
  (`dev_entity_browser.services.yml`), injected with `entity_type.bundle.info`,
  `entity_field.manager`, `entity_type.manager`.
- **One theme hook** `dev_entity_browser_report` (`hook_theme()` in `.module`), template
  `templates/dev-entity-browser-report.html.twig`, CSS library
  `dev_entity_browser/dev_entity_browser-report` (`css/dev_entity_browser.css`).
- **One menu link** `dev_entity_browser.eventiy_browser` under `system.admin_reports`
  (`dev_entity_browser.links.menu.yml`) — the link sits in the Reports menu even though the route
  path is under `/admin/structure`.

## Mechanism (from source)

- `DevEntityBrowser::buildReport()` calls `entityTypeManager->getDefinitions()`, keeps only
  `ContentEntityType` instances, and skips entity types `block_content` and `webform_submission`.
- For each remaining type it reads bundles from `entityTypeBundleInfo->getBundleInfo()`, merges the
  site-wide field map (`entityFieldManager->getFieldMap()`) and per-bundle definitions
  (`entityFieldManager->getFieldDefinitions()`), and records label, type, description, cardinality.
- `exploreType()` adds extra detail for `file`, `image`, `entity_reference`,
  `entity_reference_revisions`, `list_string`, `list_integer`, `list_float` by loading
  `FieldConfig::loadByName()` and copying `allowed_values` / reference `target_bundles`.
- Output is sorted by label and rendered as `#theme => 'dev_entity_browser_report'`. It reports
  **field/bundle definitions only — never stored content values**. Twig auto-escapes all cells.

## Operate it

- Enable: `drush en dev_entity_browser`. Grant **View Dev Entity Browser** to the intended role.
- Visit `/admin/structure/dev-entity-browser` (or Reports → Developer Entity Browser).
- Details in [reports/entity-browser.md](reports/entity-browser.md).
