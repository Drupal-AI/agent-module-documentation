<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete Users CSV (delete_users_csv) — agent index

An admin utility with **one form** that deletes user accounts matched by **email address** from an
uploaded **CSV file**, using the Batch API. Package `Other`. **No dependencies** beyond Drupal core.
Core requirement `^10.3 || ^11.0`. License GPL-2.0-or-later. Version 8.x-1.1.

- **The form, route, upload validation, CSV parsing and batch deletion** →
  [forms/delete-users.md](forms/delete-users.md)

## What it actually is

- One route `delete_users_csv.upload_file` at **`/admin/delete-users-csv`**
  (`delete_users_csv.routing.yml`), a `_form` route rendering
  `Drupal\delete_users_csv\Form\DeleteUsersCsv`, gated by core permission **`administer users`**.
  Declared as the module's `configure` route in the info file and linked under
  *People* (`entity.user.collection`) via `delete_users_csv.links.menu.yml`.
- `DeleteUsersCsv` (`src/Form/DeleteUsersCsv.php`, extends core `FormBase`): one required
  `managed_file` field (`#upload_validators` = `FileExtension: ['csv']`, `#upload_location:
  'public://'`). `submitForm()` loads the saved `File` entity, reads it with `fgetcsv()`, and
  collects every cell value containing `@` (trimmed of whitespace + BOM) as an email.
- `DeleteUsersBatch` (`src/DeleteUsersBatch.php`): static batch callbacks. `deleteUsers()` loads
  each address via user storage `loadByProperties(['mail' => …])` and calls `$user->delete()`;
  `deleteUsersCallback()` reports "@count users deleted." and logs to channel `delete_users_csv`.

## What it does NOT provide

- **No** custom permission (uses core `administer users`), **no** config schema / settings object,
  **no** Drush commands, **no** plugins, **no** services, **no** hooks, **no** `.install`. Deletion
  goes through the entity API (`$user->delete()`), not raw SQL. Email matching is row- and
  column-agnostic — any `@`-containing cell in any position is treated as an address.
