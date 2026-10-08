<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submission Import (webform_submission_import) — agent index

Adds an "Import Submissions" tab to each webform for bulk-creating submissions from an
uploaded CSV. Depends on `webform`. No config, schema, permissions, plugins, or Drush of its
own — one admin form.

- **The import route/tab, CSV format, header→element mapping, validation & logging behaviour** →
  [configure/import.md](configure/import.md)

Key facts:
- Route `webform_submission_import.import_submissions` →
  `/admin/structure/webform/manage/{webform}/submission_import`, permission `administer webform`
  (`restrict access: true`), `_admin_route: TRUE`. Local task tab weight 60.
- CSV first row = headers matching webform element keys; each later row → a submission `data`
  array. Extra columns ignored; invalid rows skipped and logged (`webform_submission_import`).
- Imports run through core webform `WebformSubmissionForm::validateFormValues()` +
  `submitFormValues()`, only while the webform `isOpen()`.
- Upload is a `.csv`-only `managed_file` into `public://webform_submission_imports/`.
- The import is gated by the trusted `administer webform` permission
  (`restrict access: true`); a trusted webform admin creating submissions is by design.
