Field Report adds a single admin report page that lists every configured field across all entity types and bundles, with each field's label, type, description, which other bundles reuse it, and per-field edit/delete links.

---

Enabling the module (which depends on core `field_ui`) exposes one route, `field_report.fields_report` at `/admin/reports/fields/field-report`, gated by the `administer field_report` permission and marked `_admin_route: TRUE`; it also appears as a menu link and local task under the Field storage collection (`/admin/reports/fields`). `FieldReportController::getEntityBundles()` iterates all entity type definitions that declare a `bundle_entity_type`, and for each bundle collects its `FieldConfig` fields (sorted by the bundle's entity-form-display weight) and builds a table with columns Field Label, Field Type, Field Description, "Also Used In" (other bundles sharing the same field storage, derived from `EntityFieldManager::getFieldMap()`), and Options (Edit/Delete links, rendered only when the current user has update/delete access to the field). Node, media, comment, contact form, taxonomy, block, and shortcut entity types get friendlier group headings; every other bundleable entity uses its own label. It is a read-only reporting tool — no configuration, no config schema, no Drush, just a small admin CSS library for the tables.

---

- See every configured field on the site grouped by entity type and bundle on one page.
- Identify fields that are missing descriptions or have unclear labels.
- Find fields shared across multiple bundles via the "Also Used In" column.
- Spot opportunities to reuse an existing field storage instead of creating a new one.
- Locate every bundle that uses a specific field before deleting the field storage.
- Jump straight to a field's edit form from the report.
- Jump straight to a field's delete form from the report.
- Audit field types in use across content types, media, taxonomy, comments, blocks, and more.
- Review the field inventory during a site build or content-model review.
- Hand a client or editor a readable overview of the content model.
- Check field naming and labeling consistency across bundles.
- Review fields in the order they appear on each bundle's edit form.
- Verify a migration created the expected fields on each bundle.
- Confirm a config import produced the intended field layout per bundle.
- Use it as a lightweight alternative to exporting config just to inspect fields.
- Restrict who can view the report via the `administer field_report` permission.
- Give editors read access to the report without granting field-config edit rights (Edit/Delete links stay hidden for them).
- Catch orphaned or unexpectedly duplicated fields across entity types.
- Document the site's fielded architecture without installing a heavier reporting module.
- Quickly answer "which content types have this field?" during support or onboarding.
- Include contrib bundleable entity types (any entity with a `bundle_entity_type`) in the audit automatically.
