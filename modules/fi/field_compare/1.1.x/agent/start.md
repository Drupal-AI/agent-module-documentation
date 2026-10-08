<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Compare — agent orientation

D10 reporting module. Routes under `admin/reports/field-compare` gated by permission `access field compare` (restrict access: TRUE).

- Controller `src/Controller/FieldCompareController.php`; services `FieldCompareOverview`, `FieldConfigData`, `OverviewSettings`.
- Read-only admin report comparing field config across bundles/entity types; AJAX settings update route (same permission).
- Extensible via `field_compare.api.php`. No mutation of content, no public/anon routes. No security findings.
