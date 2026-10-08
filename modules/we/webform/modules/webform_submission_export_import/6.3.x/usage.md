Webform Submission Export/Import lets you export webform submissions to CSV and, crucially, import submissions back in from an uploaded CSV — for bulk creation, migration, or round-tripping edits.

---

Core Webform can export results, but it cannot import them; this module adds the missing import side plus a matching exporter. It provides a **WebformExporter** plugin that produces an import-compatible CSV (with example/template downloads), and an upload form at `/admin/structure/webform/manage/{webform}/results/upload` where an admin uploads a CSV to create or update submissions in bulk. The heavy lifting is done by the `webform_submission_export_import.importer` service (`WebformSubmissionExportImportImporter`), which maps CSV columns to webform elements, validates rows, handles source-entity and file references, and reports created/updated/skipped counts. Example CSV download/view routes help authors build a correctly shaped file, and route subscribers expose the upload flow on both webforms and webform nodes. It is the go-to tool for seeding a form with legacy data, migrating submissions between environments, or applying spreadsheet edits back to Drupal.

---

- Import submissions from a CSV file into a webform in bulk.
- Migrate submissions from a legacy system into Drupal.
- Seed a new form with historical/backfill data.
- Move submissions between dev, stage, and production.
- Download an example CSV template shaped for a specific webform.
- Preview the expected import format before uploading.
- Bulk-create submissions from a spreadsheet.
- Update existing submissions by re-importing edited rows.
- Round-trip: export to CSV, edit in a spreadsheet, import back.
- Consolidate submissions from multiple sources into one webform.
- Map CSV columns to webform elements automatically.
- Import submissions tied to a source entity (e.g. a node).
- Load survey responses collected offline.
- Restore submissions from a CSV backup.
- Bulk-import event registrations from an external registration export.
- Import contact/lead lists into a webform for follow-up.
- Validate rows on import and see created/updated/skipped counts.
- Handle file/attachment references during import where supported.
- Populate a demo site with realistic sample submissions.
- Do the same upload flow for webform-node forms.
- Standardize data by re-importing a cleaned export.
