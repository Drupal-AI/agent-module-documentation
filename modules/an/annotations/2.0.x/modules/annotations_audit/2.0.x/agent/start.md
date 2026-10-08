<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Audit (annotations_audit) — agent index

Annotation coverage reporting + site-structure scan/drift detection. Depends on `annotations`; suggests `annotations_ui`. See [audit.md](audit.md) for services and drift model.

## Provides

- **Routes** (`annotations_audit.routing.yml`, under `/admin/config/annotations/audit`):
  - `annotations_audit.coverage` `/…/coverage` (`view annotation audit coverage`) → `CoverageController::page`.
  - `annotations_audit.scan` `/…/scan` (`administer annotations audit scan`) → `ScanController::overview`.
- **Services**: `annotations_audit.coverage_service` (`CoverageService`), `annotations_audit.scan_service` (`ScanService`; uses `@state` + `@database`), logger channel `annotations_audit`.
- **Controllers**: `CoverageController`, `ScanController`. **Forms** (`src/Form/`): `CoverageFilterForm`, `ScanRunForm`, `CheckChangesForm`, `DismissDriftForm`.
- **Drush** `AnnotationsAuditCommands`: `annotations:scan` (ann:scan) with `--fields`, `--format=table`, `--diff`, `--check`.
- **Hooks** `AnnotationsAuditHooks`: `help`, `theme`, `cron` (accumulates drift), `form_annotation_type_form_alter` (adds the `affects_coverage` third-party setting).
- **Permissions**: `view annotation audit coverage` (not restricted), `administer annotations audit scan`.
- **Config schema**: third-party setting `annotations.annotation_type.*.third_party.annotations_audit.affects_coverage` (bool).
- **Menu**: report entries under `system.admin_reports`.

## Notes for agents

- Waypoint snapshots, accumulated changes, and dismissed drift are stored in **State** (`annotations_audit.*`), not config.
- Coverage counts respect each type's `affects_coverage` flag. Scope drift = fields present in Drupal but not yet in a target's `fields` scope, using the plugin system's "notable" field subset to stay low-noise.
- All routes are admin-gated; scan running is a form (CSRF-protected).
