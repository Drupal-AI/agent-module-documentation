<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User CSV Import — agent index

Adds an **"Import users from CSV"** form at `/admin/people/import` that creates one user per CSV
row. No settings page (`configure: null`); options are chosen on the import form itself and can
optionally be saved to a config object.

- **The import form fields, saved config, CSV structure, passwords & emails** →
  [configure/import-config.md](configure/import-config.md)
- **How the import runs: controller, user creation, sample CSV, action link** →
  [api/import.md](api/import.md)

Key facts:
- Route `user_csv_import.admin_upload` → `/admin/people/import`, permission **`administer users`**
  (core). Action link on `entity.user.collection`.
- Form id `user_csv_import_form`. Saved options config object: **`user_csv_import.importconfig`**
  (keys `roles`, `status`, `password`, `registration_email_type`, `config_fields`) — only
  written when "Save configuration" is ticked.
- CSV: header row = field machine names; **`name` and `mail` are mandatory** fields.
- Import logic: `UserCsvImportController::processUpload()` / `::createUser()`.
- No permissions of its own, no config schema, no Drush, no plugin types.
- Submodule **roleassign_with_user_csv_import** →
  [../../modules/roleassign_with_user_csv_import/2.0.x/agent/start.md](../../modules/roleassign_with_user_csv_import/2.0.x/agent/start.md)
