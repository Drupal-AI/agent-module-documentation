<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the import runs

## Entry points

- Route `user_csv_import.admin_upload` → `/admin/people/import`
  (`UserCsvImportController::importPage()` just builds the `UserCsvImportForm`),
  permission **`administer users`** (core).
- Action link `user_csv_import_admin_upload` on `entity.user.collection` (the People page):
  "Import users from CSV".

## Processing (`UserCsvImportController::processUpload(File $file, array $config)`)

Static method, called from the form's `submitForm()`. For each row after the header:

1. Reads the header row and records the **column position** of each selected field.
2. `prepareRow()` builds the user values:
   - username = lowercased first column, **uniquified** by appending `1`, `2`, … if it already
     exists (`usernameExists()` entity query on `name`);
   - `pass` = the row's `pass` column if non-empty, else `$config['password']`;
   - `timezone` defaults to `system.date` default; `status`, `roles`, `created` from config.
3. `createUser()` → **skips** the row if `user_load_by_mail($mail)` already returns a user
   (logs + messages "Email already in use"); otherwise `User::create($values)->save()`.
4. If `registration_email_type !== 'none'`, calls `_user_mail_notify($type, $user)`.

Returns an array of created users keyed by new uid; the form then messages
"Successfully imported N users." and redirects to the People page.

## Generate sample CSV (`UserCsvImportForm::generateSample()`)

The **Generate sample CSV** button streams a `text/csv` download
(`user-csv-import-sample.csv`) whose header is the ticked fields and whose two example rows use
`john`/`jane` sample data, so editors get a correctly-shaped template.

## Notes for scripting / evals

- The module has **no Drush command**; imports go through the form/controller.
- Programmatic reuse is possible by calling
  `\Drupal\user_csv_import\Controller\UserCsvImportController::processUpload($file, $config)`
  with a saved `file` entity and a `$config` array
  (`separator`, `password`, `status`, `roles`, `fields`, `registration_email_type`).
- Creating `User` entities is standard core behaviour; the module adds the CSV mapping,
  username uniquification and email-dedup on top.
