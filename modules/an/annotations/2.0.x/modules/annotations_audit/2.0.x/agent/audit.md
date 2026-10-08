<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Audit — coverage, scan, drift

## Coverage — `CoverageService` (`src/CoverageService.php`) + `CoverageController`

Computes, per target, how many annotation slots (overview + in-scope fields × applicable types) are filled versus available, reading via `AnnotationStorageService`. Annotation types are counted only when their per-type `affects_coverage` flag (third-party setting `annotations_audit`, default handled by `AnnotationsAuditHooks::formAnnotationTypeFormAlter`) is on. `CoverageController::page` renders the report at `/admin/config/annotations/audit/coverage` (`view annotation audit coverage`), filterable via `CoverageFilterForm`; rows link into the annotate/edit UI when annotations_ui is installed.

## Scan & drift — `ScanService` (`src/ScanService.php`) + `ScanController`

State-backed (no config). Key methods:
- `scan()` — builds the current annotatable-structure result from the target plugin manager + field manager.
- `saveSnapshot($result)` / `loadSnapshot()` — the waypoint baseline (`@state`).
- `computeDiff($current, $stored)` / `diffHasChanges($diff)` — structural additions/removals vs. the waypoint.
- `getAccumulatedChanges()` / `mergeNewChanges($diff)` / `clearAccumulatedChanges()` — drift accumulated over time (State key `annotations_audit.accumulated_changes`); cron (`AnnotationsAuditHooks::cron`) merges new changes; setting a new waypoint clears them.
- `getScopeDrift()` — fields available in Drupal but not in a target's `fields` scope (limited to the "notable" base-field subset to stay low-noise); `getDismissedDrift()` / `dismissDriftField()` / `clearDismissedDrift()` manage per-field dismissals (State key `annotations_audit.dismissed_drift`).
- `getLastScanTimestamp()`.

`ScanController::overview` (`/…/scan`, `administer annotations audit scan`) shows scan status + accumulated changes; `ScanRunForm` runs a scan / sets a waypoint, `CheckChangesForm` accepts current structure, `DismissDriftForm` manages scope-drift dismissals. All are forms (CSRF-protected).

## Drush — `AnnotationsAuditCommands`

`annotations:scan` (alias `ann:scan`), options: `--fields` (include field detail), `--format=table`, `--diff` (show diff vs. waypoint), `--check` (exit non-zero when drift exists — for CI). Prints a summary or diff table.
