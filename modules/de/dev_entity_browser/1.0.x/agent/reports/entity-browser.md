<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer Entity Browser — the report route & builder

## Install / enable

`drush en dev_entity_browser` (or enable at `/admin/modules`). No dependencies beyond Drupal core
`^10 || ^11`; no libraries, no config to import. After enabling, grant the permission below to the
roles that should see the report.

## Route & permission

- Route `dev_entity_browser.entity_browser` — `dev_entity_browser.routing.yml`:
  - path `/admin/structure/dev-entity-browser`
  - `_title: 'Developer Entity Browser'`
  - `_controller: '\Drupal\dev_entity_browser\Controller\DevEntityBrowserController'` (invokable)
  - `requirements: _permission: 'view dev entity browser'`
- Permission `view dev entity browser` — `dev_entity_browser.permissions.yml`, title
  "View Dev Entity Browser", `restrict access: true` (treated as a security-sensitive permission).
- Menu link `dev_entity_browser.eventiy_browser` (`dev_entity_browser.links.menu.yml`) parents the
  entry under `system.admin_reports`, so the UI entry point is **Reports → Developer Entity Browser**.
  (Note: the link's YAML key is spelled `eventiy_browser`; the README's `/admin/reports/…` path is
  stale — the real route path is `/admin/structure/dev-entity-browser`.)

## Controller

`src/Controller/DevEntityBrowserController.php` — `final class DevEntityBrowserController extends
ControllerBase`. Constructor-injects the `dev_entity_browser.dev_entity_browser` service via
`create()`. It is invokable: `__invoke(): array` returns `$this->devEntityBrowser->buildReport()`.
No arguments, no request/query input, no state change.

## Service: `DevEntityBrowser::buildReport()`

`src/Service/DevEntityBrowser.php`, service id `dev_entity_browser.dev_entity_browser`. Dependencies
(`dev_entity_browser.services.yml`): `@entity_type.bundle.info`, `@entity_field.manager`,
`@entity_type.manager`. All data comes from these managers — no database queries, no external calls.

Build steps:
1. `collectEntityDefinitions()` → `entityTypeManager->getDefinitions()`; keep only instances of
   `Drupal\Core\Entity\ContentEntityType` (config entity types are ignored).
2. Skip entity types `block_content` and `webform_submission` (hardcoded `switch` in the loop).
3. For each kept type record `label`, `machine_name`, `class_name` and iterate bundles from
   `entityTypeBundleInfo->getBundleInfo($id)`.
4. `collectFieldMaps()` → `entityFieldManager->getFieldMap()` provides the aggregated
   `fieldMap` (field name → type + bundles). Per-bundle definitions come from
   `entityFieldManager->getFieldDefinitions($entityTypeId, $bundleId)`.
5. Per field it stores `description`, `label_label` (field label), `label_key` (field name),
   `cardinality` (via `getCardinality()` when available, else 1), and, when the item definition
   exposes `allowed_values`, copies them.
6. `exploreType()` adds a `settings` report for field types `file`, `image`, `entity_reference`,
   `entity_reference_revisions`, `list_string`, `list_integer`, `list_float`: it loads
   `FieldConfig::loadByName($entityId, $bundleId, $fieldKey)` (falling back to the field
   definition's own `getSettings()` if no `FieldConfig`) and, in `getFieldSettingsReport()`, copies
   string settings and reference `target_bundles`.
7. The table of contents is re-keyed by `label . id` and `ksort`ed (`SORT_STRING`) so the report is
   ordered by human label.
8. Returns `['dev_entity_browser_report' => ['#type' => 'dev_entity_browser_report',
   '#theme' => 'dev_entity_browser_report', '#report' => $sorted]]`.

Helper `convertLabelToString()` normalizes translatable/`Markup`/string labels to a plain string.

## Theme & assets

- `hook_theme()` (`dev_entity_browser.module`) registers `dev_entity_browser_report` with a single
  `report` variable.
- Template `templates/dev-entity-browser-report.html.twig` renders a table of contents plus, per
  entity type, a bundle list and a fields table (Field / Type / Overview) using Claro `details`
  and `sticky-header` classes. All values print through normal Twig auto-escaping (no `|raw`).
- Library `dev_entity_browser/dev_entity_browser-report` (`dev_entity_browser.libraries.yml`)
  attaches `css/dev_entity_browser.css` (layout only).

## What it does NOT do

- No settings form, no config objects, no config schema, no install/update hooks.
- No plugins, no Drush commands, no events, no REST resources.
- Reports **field and bundle definitions/settings only** — it never loads or renders the stored
  field values of any content entity.
