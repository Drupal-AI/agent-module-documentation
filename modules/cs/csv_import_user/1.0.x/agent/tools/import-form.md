<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import form — CSV user import

Single admin tool. No configuration to store; behavior is fixed in code.

## Install / enable
- `drush en csv_import_user` (pulls core `user` + `file`). No settings form beyond the
  import page itself; `configure` in the `.info.yml` points at the import route.

## Route & access
- `csv_import_user.import_form`: `GET /admin/config/people/user-import`,
  `_controller: UserImportController::importForm`, `_title: 'Import Users from CSV'`,
  `requirements._permission: 'administer users'`.
- `UserImportController::importForm()` just returns
  `form_builder->getForm('Drupal\csv_import_user\Form\UserImportCsvForm')`.

## Form (`UserImportCsvForm`, form id `user_import_csv_form`)
- `buildForm()` renders:
  - `csv_file` — `#type => file`, `#required => TRUE`.
  - `custom_fields` — `#type => checkboxes` (only shown if the user entity has any
    non-base fields). Options come from `getUserCustomFields()`: every `field_config`
    with `entity_type => user`, minus base fields `name`, `mail`, `status`; keyed by
    field machine name, labelled by field label.
  - `submit` — "Import Users".
- `create()` injects `entity_type.manager`, `file_system`, the `user_role` storage, and
  `file.repository`.

## Upload validation (`submitForm()`)
- `file_save_upload('csv_file', $validators, FALSE, 0)` with
  `$validators = ['FileExtension' => ['extensions' => 'csv'], 'FileSizeLimit' => ['fileLimit' => 5242880]]`
  → `.csv` only, 5 MB max. On failure: error message "Only CSV files are allowed."
- On success the file entity is reloaded, parsed, and users are imported;
  a "User import complete." message is shown.

## CSV format & parsing (`parseCsv()`)
- Opens the file's real path, reads the **first row as headers** (`fgetcsv`), then
  `array_combine($headers, $row)` for each data row → array of assoc rows keyed by header.
- No delimiter/encoding options; default `fgetcsv` (comma). Malformed `array_combine`
  (header/column count mismatch) is not guarded.

## Import logic (`importUsers()`)
- Per row, requires `username` and `email`; otherwise a warning "missing required
  fields" and the row is skipped.
- If a user with that `name` already exists → warning, skip (no update of existing users).
- Otherwise creates `user` entity with `name => username`, `mail => email`,
  `status => 1` (active). **No password is set** — imported accounts get no password and
  would use the standard reset/one-time-login flow to gain one.
- For each ticked `custom_fields` entry present in the row: `$user->set($field_name, $value)`.
  Special case `user_picture`:
  - If a managed `file` already exists with that URI → mark permanent, save, set as
    `user_picture` target.
  - Else `file_get_contents($file_uri)` on the raw cell value and, if data is returned,
    write it to `public://pictures/<basename>` via `file.repository->writeData(..., FileExists::Replace)`,
    mark permanent, and set as `user_picture`. Warnings on fetch/save failure.
- Role: if a `role` column is present, `roleStorage->load(trim($role))`; if the role
  exists, `$user->addRole($role_name)`, else a "Role not found" warning. The role name is
  the role **machine name**.
- `$user->save()`; success message per imported user.

## CSV example
```
username,email,role,field_company,field_address
jdoe,jdoe@example.com,editor,Acme,123 Main St
```
Headers must match the target field machine names (and `role` uses the role machine name).
Only fields ticked in the `custom_fields` checkboxes are applied even if present in the CSV.

## Operating notes
- No batching: all rows are processed in the single form submit — very large files (near
  the 5 MB limit) run in one request.
- No config export/schema; nothing to `drush cget`. The module stores no state itself
  beyond the created user + file entities.
