Entity Import gives site administrators a point-and-click UI to import content entities from uploaded CSV files by building migrations (source, field mappings, processing, dependencies) without writing YAML.

---

Entity Import is a Migrate-API framework wrapped in an admin interface. You create an "importer" config entity that fixes a source plugin (CSV ships in core of the module) plus a target entity type and one or more bundles; you then add field-mapping config entities that map CSV columns (by source name / header) to entity fields or field properties, optionally chaining migrate process plugins (default value, explode, extract, flatten, format date, machine name, skip on empty, callback, migrate lookup, and — via the entity_import_plus submodule — entity lookup, entity generate, string replace). Each importer/bundle pair is exposed to Migrate as a derived migration (`entity_import:<importer>:<bundle>`), so importers can declare optional dependencies on other migrations and run them in order from a single screen. Importers marked "expose" appear on an import page where an admin uploads the file(s), optionally ticks "Update" to overwrite matching entities, downloads a header template, and runs the import in a batch. Unique identifiers (defined per importer) become the migration's IDs so re-imports update rather than duplicate; a status/rollback tab and a per-importer log tab round out operations. All routes and the config entity require the `administer entity import` permission.

---

- Bulk-load nodes from a spreadsheet exported by an editor, mapping columns to title/body/fields.
- Import taxonomy terms from a CSV, auto-creating referenced parents via entity generate.
- Load users (or other content entities) from a CSV with per-field processing.
- Update an existing content set: re-upload the CSV with "Update" checked to overwrite matched entities keyed by a unique identifier.
- Build a multi-step import where a "categories" importer must run before a "products" importer, declared as a migration dependency and executed in order from one form.
- Map a single CSV column to a multi-value field by exploding on a delimiter.
- Resolve a human-readable value (e.g. a term name) to an entity reference target ID using the migrate lookup or entity lookup process.
- Auto-create a referenced entity that does not yet exist during import using the entity generate process (entity_import_plus).
- Normalize inbound date strings into Drupal's storage format with the format-date process.
- Skip rows/values that are empty using skip-on-empty, keeping partial spreadsheets clean.
- Generate machine names from a label column with the machine-name process.
- Apply search/replace (literal or regex, with CHR: escape codes) to inbound values via the string-replace process (entity_import_plus).
- Transform values through a custom PHP callable for one-off cleanups (callback process).
- Give non-technical staff a self-service import page per content type without exposing raw migrations.
- Download a ready-made CSV header template for an importer so contributors know exactly which columns to fill.
- Import multiple CSV files in one go when "Upload multiple files" is enabled on the source.
- Convert CSV character encoding on read (e.g. from ISO-8859-1 to UTF-8) via the source encoding option.
- Validate imported entities against field constraints during migration by enabling the importer's "validate" option.
- Roll back a bad import and remove the created entities from the importer's action/status tab.
- Review per-migration log messages to diagnose why specific rows failed.
- Clear an importer's accumulated log from the log tab.
- Stand up a repeatable content-seeding workflow for staging/QA environments driven by CSV fixtures.
- Migrate legacy flat-file data into structured Drupal entities without a bespoke custom module.
- Chain several process plugins on one field to clean, split, and look up a value in a defined order.
