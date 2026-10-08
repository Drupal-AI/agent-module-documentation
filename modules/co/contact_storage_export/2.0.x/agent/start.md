# Contact Storage Export — agent index

Adds an **Export submissions** operation to every contact form (on `/admin/structure/contact`)
that downloads stored Contact Storage submissions as CSV. No settings UI (`configure` = null);
options are chosen per-export on the form. Depends on `contact`, `contact_storage`,
`csv_serialization`.

- **Running an export: the operation, form options, download flow, "since last export"** →
  [configure/export.md](configure/export.md)
- **The `contact_storage_export.exporter` service and its methods (serialize/encode/getLabels)** →
  [api/service.md](api/service.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission `export contact form messages` gates the operation and both routes.
- Export form `entity.contact_form.export_form` → `/admin/structure/contact/manage/export`;
  download `contact_storage_export.contact_storage_download_form`.
- Service id `contact_storage_export.exporter` (`ContactStorageExportService`).
- "Since last export" watermark lives in key/value store `contact_storage_export.<form_id>` → `last_id`
  (via `ContactStorageExport::get/setLastExportId()`).
- No config object, no schema, no Drush.
