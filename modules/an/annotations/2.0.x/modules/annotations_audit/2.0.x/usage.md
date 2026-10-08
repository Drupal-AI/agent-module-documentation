<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Audit reports annotation coverage and detects site-structure drift against a recorded waypoint.

---

Annotations Audit answers "what is documented and what changed?". Its coverage report (`/admin/config/annotations/audit/coverage`) lists every included target with how many annotation slots are filled versus available, so gaps are visible at a glance; annotation types can be excluded from the coverage calculation via a per-type `affects_coverage` third-party setting on the type edit form. Its scan feature (`/admin/config/annotations/audit/scan`) records a waypoint snapshot of the site's annotatable structure (`ScanService`), then compares the current structure to that baseline and reports accumulated additions/removals (drift), which cron keeps up to date and which admins can dismiss per field or clear by setting a new waypoint. Scope drift (fields available in Drupal but not yet in a target's scope) is surfaced separately with per-field dismissal. The `annotations:scan` Drush command (alias `ann:scan`) runs the same scan/diff for CI, with `--check` returning a non-zero exit on drift. Coverage viewing needs `view annotation audit coverage`; running scans needs `administer annotations audit scan`. Depends on `annotations`; suggests annotations_ui.

---

- Report annotation coverage per target (filled vs available slots).
- Show which targets and fields are undocumented.
- Exclude specific annotation types from the coverage calculation.
- Link coverage rows to the annotate/edit UI (with annotations_ui).
- Filter the coverage report (CoverageFilterForm).
- Record a waypoint snapshot of the site's annotatable structure.
- Detect additions/removals in structure since the last waypoint (drift).
- Accumulate structural changes over time via cron.
- Dismiss individual scope-drift fields to keep the notice low-noise.
- Clear drift by setting a new waypoint.
- Detect scope drift (fields available in Drupal but not in a target's scope).
- Run scans and diffs from the command line (`drush annotations:scan`).
- Fail CI on structural drift (`--check` non-zero exit).
- Output scan results as a table or diff.
- Gate coverage viewing behind `view annotation audit coverage`.
- Gate scan administration behind `administer annotations audit scan`.
- Surface an admin-report menu entry under Reports.
