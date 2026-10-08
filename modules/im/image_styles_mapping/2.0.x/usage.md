<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Styles Mapping adds an admin report at Reports → Image Styles Mapping that lists every place image styles and responsive image styles are used — across entity view-display image fields and across Views field handlers.

---

The module registers three routes under `/admin/reports/image_styles_mapping_report` (all, fields, views), each gated by the `access_image_styles_mapping_report` permission and shown as local tasks/tabs. `ImageStylesMappingService` builds two reports: `fieldsReport()` loads all `entity_view_display` config entities and records every field formatter of type `image` or `responsive_image` (entity type, bundle, view mode, field, plus per-plugin columns), and `viewsFieldsReport()` scans all View displays for image fields; the views report route additionally requires the `views` module (`_module_dependencies: views`). Rows are sortable via core TableSort and link to the relevant view-mode or view-display edit page when the current user has access. The columns for "which style is used" are produced by an extensible `ImageStylesMapping` plugin type (manager `plugin.manager.image_styles_mapping.image_styles_mapping`, plugins `Image` and `ResponsiveImageStyles`), so additional style-mapping columns can be added by other modules.

Typical use is read-only auditing: grant the permission to a site-builder/admin role, open the report before deleting or refactoring an image style, and confirm nothing still references it. Security posture is safe — the report is permission-gated, performs no writes, runs no user-supplied SQL (TableSort's `sql` key is used only for in-PHP sorting), and the dynamic `$this->{$report_name}()` dispatch is limited to a hardcoded whitelist of report names from route defaults.

---
- Audit which image styles are used before deleting one.
- List all image-field formatters and their configured image style.
- List all responsive image styles used across view displays.
- Find every entity type/bundle/view mode using a given image field.
- See which Views field handlers render an image style.
- Jump from a report row to the field's view-mode edit page.
- Jump from a report row to the Views display edit page.
- Sort the report by entity, bundle, view mode, or field.
- Verify no view display references a style you plan to remove.
- Confirm responsive image style coverage across content types.
- Give a site builder read-only access to the styles report.
- Review image-style usage during a theme refactor.
- Check both fields and views usage on one combined page.
- Detect duplicated image fields reused across views (field_image_1 etc.).
- Document current image-style usage for a site audit.
- Plan a migration of image styles by seeing all references first.
- Restrict the report to admins via the dedicated permission.
- Extend the report with a custom style-mapping plugin column.
- Skip the views tab automatically when Views is disabled.
- Export findings manually from the rendered report tables.
