<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Submission Import adds an "Import Submissions" tab to each webform where an administrator can upload a CSV file and bulk-create webform submissions from its rows.

---

The module adds a single admin route/tab (`webform_submission_import.import_submissions`) at `/admin/structure/webform/manage/{webform}/submission_import`, gated by the `administer webform` permission. `SubmissionImportForm` lists the webform's fields (flattened, excluding wizard pages) split into required and additional, and offers a `managed_file` upload restricted to `.csv` (stored in `public://webform_submission_imports/`). On submit it reads the CSV with `fgetcsv`, treats the first row as headers (which must match the webform element keys), maps each subsequent row into a `data` array via `array_combine`, and imports each through the standard webform pipeline: `WebformSubmissionForm::validateFormValues()` then `WebformSubmissionForm::submitFormValues()`. Rows that fail validation are skipped and logged (via the `webform_submission_import` logger channel) rather than aborting the whole import; extra CSV columns not matching a field are ignored, and imports only run while the webform is open (`WebformSubmissionForm::isOpen`). To handle large files it temporarily raises `memory_limit` to 8192M and the time limit to 1800s during import, then reports a count of successfully imported submissions. There is no config, schema, permissions, Drush, or plugins of its own.

---

- Bulk-load historical webform submissions from a CSV export.
- Migrate submissions from a legacy form/system into a Drupal webform.
- Seed a new webform with test/sample submission data from a spreadsheet.
- Import survey responses collected offline into the matching webform.
- Re-import submissions after rebuilding or renaming a webform (matching element keys).
- Load contact/registration entries gathered elsewhere into a webform's results.
- Populate a webform's submission table for reporting/aggregation without manual entry.
- Batch-create submissions that run through the webform's normal validation.
- Skip and log invalid rows while still importing the valid ones from a large CSV.
- Ignore extra spreadsheet columns that don't correspond to form fields.
- Import into a multi-page (wizard) webform (wizard-page pseudo-elements are excluded from the field list).
- Check which fields are required vs. optional before preparing the CSV (shown on the import form).
- Move submissions between environments (export CSV on one site, import on another).
- Restore submissions from a CSV backup into an open webform.
- Bulk-add newsletter/lead entries captured in a CRM export into a webform.
- Import large submission datasets that would time out or exhaust memory with default limits.
- Give site admins a UI-driven bulk import instead of scripting `WebformSubmission` entities.
- Consolidate submissions from several sources into one webform via successive CSV imports.
