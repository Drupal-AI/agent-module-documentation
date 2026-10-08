<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Compare gives site builders an overview to compare how fields are configured across bundles and entity types — surfacing differences in field storage and instance settings that are easy to miss. It is a read-only reporting tool under Reports.

---

- Drupal 10; no module dependencies beyond core.
- Enable with `drush en field_compare`.
- Visit `admin/reports/field-compare` (permission: "access field compare", restricted).
- Drill into a specific entity type at `admin/reports/field-compare/{entity_type}`.
- Adjust which columns/settings are shown via the overview settings (AJAX-updated).

---

- Compare field configuration across bundles of an entity type.
- Spot inconsistent field settings (e.g. cardinality, required, defaults).
- Audit field storage vs instance-level configuration.
- Review fields per entity type from a single report.
- Toggle displayed settings via overview settings (AJAX).
- Support content modeling audits and clean-up.
- Identify duplicate or near-duplicate fields.
- Help plan field consolidation/refactors.
- Provide a read-only, non-destructive overview.
- Restrict access with a dedicated permission.
- Integrate under the core Reports section.
- Use the `FieldConfigData` service for field metadata.
- Extend comparisons via `field_compare.api.php` hooks.
- Inspect translation/revision-related field flags.
- Assist migrations by comparing source/target field config.
- Aid QA before configuration exports.
