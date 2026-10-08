<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSV Import Users (csv_import_user) — agent index

Admin utility that bulk-creates Drupal user accounts from an uploaded CSV file. One
administrative form, no config, no plugins, no services of its own.

## What it is
- Adds the page `/admin/config/people/user-import` (route `csv_import_user.import_form`,
  `_permission: 'administer users'`).
- Uploads a `.csv` file (≤ 5 MB), parses header + rows, and creates one **active** user
  per row (`status => 1`). Rows need `username` + `email`; existing usernames are skipped.
- Optional `role` column assigns a matching user role; a checkbox list lets the admin map
  selected configured user fields (from `field_config`) onto extra CSV columns, incl.
  `user_picture` (existing managed-file URI, or a fetched-and-saved location).

## Dependencies
- Core `drupal:user` and `drupal:file`. No contrib deps, no Composer requirements beyond
  core. PHP: none declared. Core `^10.3 || ^11`.

## Structure (all source)
- `csv_import_user.routing.yml` — the single route (above).
- `src/Controller/UserImportController.php` — `importForm()` returns the form via
  `form_builder`.
- `src/Form/UserImportCsvForm.php` — `FormBase`; builds the upload form, validates the
  file (`FileExtension: csv`, `FileSizeLimit: 5242880`), parses CSV, creates users,
  assigns roles/fields. Injects `entity_type.manager`, `file_system`, `user_role`
  storage, `file.repository`.
- `csv_import_user.module` — empty (`@file` docblock only).
- No `.permissions.yml`, `.services.yml`, `.install`, `config/`, or schema.

## Provides
- Entities/plugins/services: none.
- Routes: `csv_import_user.import_form` only.
- Permissions: none of its own (reuses core `administer users`).

## Solution docs
- [Import form & how it works](tools/import-form.md) — route, permission, CSV format,
  field/role mapping, `user_picture` handling, validation.
