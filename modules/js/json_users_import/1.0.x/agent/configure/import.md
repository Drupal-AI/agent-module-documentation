<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using & configuring Json Users Import

## Field / email mapping
`/admin/config/people/json_users_import_config` (route `json_users_import.import_configuration`), form `JsonUsersImportConfig`, config object `json_users_import.import_configuration`:
- `filed_email` — JSON key holding each user's email.
- `filed_name` — JSON key holding each user's username.
- One textfield per `FieldConfig` user field — JSON key mapped into that field.
- `send_email` (bool), `email_subject` (token-replaced), `email_options` = `send_onetime_login` | `send_password`, plus `onetime_login_content` / `password_content` bodies.

## Import
`/admin/people/json_users_import` (route `json_users_import.import_user`), form `JsonUsersImport`: paste a JSON **array** of objects. `Json::decode()` must yield an array or the form reports "Not a valid Json!". A batch then, per row: validate username (`isUserNameValid`), skip if email exists (`isEmailExist`) or username exists (`isUserNameExist`), else `createUser()`.

## `createUser()` behaviour (`src/Controller/JsonUsersImportController.php`)
- Random 7-char password (`Drupal\Component\Utility\Random::name(7)`).
- `setEmail`, `setUsername`, `set('init')`, langcode fields, `activate()` → **active** account.
- Maps configured extra fields from the JSON.
- **Never assigns roles** — imported users hold only the authenticated role.
- If `send_email`, calls `sendUserAccountDetails()` (mail manager; SMTP module dependency) with a one-time login URL or the plaintext password. `hook_mail` escapes the body with `Html::escape()`.

## Security / operability notes (reported, not recorded)
- **Access is stricter than documented:** the module has no `*.permissions.yml`, so the required `json import users` permission is undefined and only user 1 can reach either route. To grant intended admins, define the permission (or the routes remain uid-1-only).
- **No privilege escalation:** because no roles are added, the import cannot mint admin/elevated accounts.
- The import does create login-enabled active accounts in bulk; treat access as sensitive once a real permission is defined.
