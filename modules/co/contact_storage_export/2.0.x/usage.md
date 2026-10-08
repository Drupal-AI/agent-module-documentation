Contact Storage Export adds a one-click "Export" operation to every contact form so stored submissions (from the Contact Storage module) can be downloaded as a CSV, including base fields and multi-value fields.

---

The module bolts a CSV export onto core Contact + Contact Storage. Via `hook_entity_operation_alter()` it adds an **Export submissions** operation to each `contact_form` on `/admin/structure/contact`, gated by the `export contact form messages` permission. The export form (`/admin/structure/contact/manage/export`) lets an editor pick which columns to include, choose a created-date format, set the CSV filename, and optionally export **only new messages since the last export**. Submissions are serialized by the `contact_storage_export.exporter` service (`ContactStorageExportService`), which formats each field type sensibly (links become absolute URLs, entity references become labels, date/created/daterange fields use the chosen date format, other fields render through their default formatter) and encodes rows with the `csv_serialization` CsvEncoder. Export runs as a Batch that writes to a temporary private (or temporary) file; on completion the user is redirected to a download form backed by the private tempstore. "Since last export" state is tracked per form in the key/value store (`contact_storage_export.<form_id>` → `last_id`). There is no configuration UI or settings (`configure` is null) and no schema; the only knobs are the per-export form options, and the module defines a single permission.

---

- Download all submissions of a contact form as a CSV file.
- Export only new submissions received since the previous export ("since last export").
- Let non-admin editors export form data by granting the export permission.
- Choose exactly which columns/fields appear in the exported CSV.
- Rename the export file before downloading (must end in `.csv`).
- Pick the date format used for created/datetime/daterange columns.
- Export multi-value fields (e.g. checkboxes) correctly in a single row.
- Turn contact-form leads into a spreadsheet for a sales/CRM handoff.
- Produce a CSV of newsletter-signup or feedback submissions for analysis.
- Archive contact submissions periodically as CSV snapshots.
- Export entity-reference field values as human-readable labels.
- Export link fields as absolute URLs.
- Give each newly created contact form export automatically, with no per-form setup.
- Avoid building a separate View per form just to export it (unlike the Views Data Export approach).
- Export submissions to feed a mail-merge or bulk-email tool.
- Hand a marketing team a self-serve CSV export without database access.
- Keep the download restricted to a private file for sensitive submissions.
- Batch-export large numbers of submissions without timeouts (25 rows per batch step).
- Reset the "last export" watermark by re-exporting all rows.
- Export a single form's submissions while ignoring others.
- Include base data (submitter, date submitted, logged-in user) alongside custom fields.
- Call the `contact_storage_export.exporter` service to serialize messages programmatically.
- Generate CSV output from `contact_message` entities in custom code via the exporter's `encode()`.
- Provide a repeatable manual export step in an editorial workflow.
