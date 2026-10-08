# Field Report (field_report) — agent index

Read-only admin report listing every configured field on the site, grouped by entity type and
bundle. Each bundle gets a table of Field Label, Field Type, Field Description, "Also Used In"
(other bundles sharing the same field storage) and Edit/Delete links. Depends on core `field_ui`.
Nothing to configure — no settings form, no config object/schema, no Drush, no plugins.

- **Reach the report and read what each column means** → [configure/overview.md](configure/overview.md)
- **Grant access to the report** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `field_report.fields_report` → path `/admin/reports/fields/field-report`, `options._admin_route: TRUE`.
- Permission `administer field_report` (title "Administer Field Report").
- Controller `\Drupal\field_report\Controller\FieldReportController::getEntityBundles`.
- Injected services: `entity_field.manager`, `entity_type.manager`, `entity_display.repository`.
- Menu link + local task parented on `entity.field_storage_config.collection` (`/admin/reports/fields`).
- Asset library `field_report/field-report` (`css/field_report.admin.css`).
- `configure` route: none.
