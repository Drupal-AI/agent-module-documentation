<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Importing submissions (webform_submission_import)

No configuration to set — the module is purely an import action per webform.

## Where

- Route: `webform_submission_import.import_submissions`
- Path: `/admin/structure/webform/manage/{webform}/submission_import`
- Permission: `administer webform` (`restrict access: true`)
- Appears as an **"Import Submissions"** local task tab on each webform (weight 60), and is an
  `_admin_route`.

## CSV format

- **First row = headers**, and each header must match a **webform element key** (machine
  name). The form lists the target webform's fields, split into *Required Fields* and
  *Additional Fields*, so you can build a matching CSV. Wizard-page pseudo-elements are
  excluded from that list.
- Each subsequent row becomes one submission: values are zipped to headers with
  `array_combine($headers, $row)` and passed as the submission `data`.
- **Extra columns** whose header doesn't match an element are ignored.
- Upload is a `managed_file` restricted to the `csv` extension, saved to
  `public://webform_submission_imports/`.

## Import behaviour (`SubmissionImportForm::submitForm` / `importRow`)

1. Loads the uploaded file, opens it with `fopen`/`fgetcsv`.
2. For each data row, builds `['webform_id' => …, 'current_page' => 'webform_submission_import',
   'data' => $rowData]`.
3. Only imports while the webform is open (`WebformSubmissionForm::isOpen($webform)`).
4. Validates each row with `WebformSubmissionForm::validateFormValues($values)`. **Invalid rows
   are skipped and logged** to the `webform_submission_import` logger channel (with a `print_r`
   of the values and errors) — the import continues.
5. Valid rows are saved via `WebformSubmissionForm::submitFormValues($values)`; a running
   count is kept and reported ("Successfully imported N submission(s).").

## Notes / gotchas

- During import the form raises `memory_limit` to `8192M` and the time limit to `1800`s
  (restored to `120`s after), to survive large files — the source even flags this with a
  `@todo This doesn't seem right`. Very large imports still run synchronously in one request
  (no Batch API), so expect it to block until finished.
- There is no de-duplication: importing the same CSV twice creates duplicate submissions.
- Values go through the webform's normal validation, so required-field and element constraints
  apply per row; rows failing them never get created.
