Entity Export CSV exports any content entity (nodes, users, taxonomy terms, media, etc.) to a CSV file, letting a site builder choose per entity type/bundle which fields are exportable and, per field, exactly how each value and property is written to columns.

---

The module has two halves. First, an admin **settings** step (`/admin/config/content/entity-export-csv/settings`, config `entity_export_csv.settings`) selects which content entity types — and optionally which bundles — may be exported. Second, an **export** form (`/admin/content/entity-export-csv`) where a user picks an enabled entity type/bundle and, field by field, whether to include it and how to render it. Field handling is delegated to a **`field_type_export` plugin type** (managed by `plugin.manager.field_type_export`, plugins in `Plugin/FieldTypeExport/`, annotation `@FieldTypeExport`): the module ships exporters for plain fields (`default_export`, weight 100 fallback), address, entity reference, file, link, datetime, daterange, timestamp, list, and geolocation. Each plugin controls how multi-value fields and multi-property fields are flattened — a single column with a separator, or one column per property/value. Reusable export definitions can be saved as **`entity_export_csv` config entities** (per entity type + bundle, with a `delimiter` and per-field `fields` settings) and managed at `/admin/config/content/entity-export-csv/configurations`. Exports run through Batch API (`EntityExportCsvBatch`) and the finished file is streamed by the download controller (prefers the private filesystem, falling back to temporary). Two events (`entity_export_csv.fields_supported`, `entity_export_csv.fields_enable`) let other modules alter the exportable/enabled field lists, and a developer can add a new `@FieldTypeExport` plugin to support custom field types. Access is gated by two permissions: *Administer Entity Export CSV* and *Use Entity Export CSV*.

---

- Export all published nodes of a content type to CSV for a spreadsheet or reporting tool.
- Export the user list (with selected profile fields) to CSV for an external CRM.
- Give non-technical editors a self-service CSV export without building a View.
- Choose per bundle which fields are exportable so exports stay on-brand and minimal.
- Export an address field either as one combined column or split into street/city/postcode columns.
- Flatten a multi-value entity reference field into a single delimiter-separated column.
- Export each property of a multi-property field into its own dedicated column.
- Export a link field's URI and title separately or together.
- Export datetime / daterange fields with a chosen date format.
- Export a timestamp (created/changed) field in a human-readable format.
- Export a list/select field by its stored key or its display label.
- Export geolocation fields (lat/lng) into CSV columns.
- Save a reusable export configuration (entity type + bundle + delimiter + field map) as a config entity.
- Duplicate an existing export configuration to quickly create a variant.
- Enable/disable saved export configurations without deleting them.
- Set a custom CSV delimiter (e.g. comma vs semicolon) per export configuration.
- Run large exports through Batch API without timing out.
- Stream finished CSVs from the private filesystem for access-controlled downloads.
- Limit who can run exports via the "Use Entity Export CSV" permission.
- Restrict export setup/administration to trusted roles via "Administer Entity Export CSV".
- Extend export support to a contrib/custom field type by writing a `@FieldTypeExport` plugin.
- Make one exporter exclusive for a specific field via the plugin `exclusive` flag.
- Alter the list of supported or enabled fields programmatically via the module's events.
- Export media entities and their file metadata to CSV.
- Export taxonomy terms of a vocabulary to CSV for review or bulk editing.
- Produce a repeatable, configuration-managed CSV export that deploys across environments.
