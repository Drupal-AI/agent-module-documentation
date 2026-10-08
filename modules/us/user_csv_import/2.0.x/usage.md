<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User CSV Import adds an "Import users from CSV" form to the People admin page that creates a new Drupal user account for each row of an uploaded CSV file, mapping columns to selected user fields.

---

The module exposes a form at `/admin/people/import` (route `user_csv_import.admin_upload`, gated by core's **`administer users`** permission; an action link appears on the People collection). On the form you upload a CSV, pick a separator character, a default password, an initial status (Active/Blocked), a registration-email type, the set of roles to grant (Authenticated is mandatory), and tick which user fields the CSV columns map to (Name and Email are mandatory). The CSV's first row holds field machine names; each subsequent row becomes a user. `UserCsvImportController::processUpload()` reads the file, resolves each selected field's column position, generates a unique username (appending a number on clash), sets the password (per-row `pass` column if present, else the default), and saves a `User` entity — skipping rows whose email already exists and optionally sending the chosen registration email. A "Generate sample CSV" button downloads a template built from the selected fields, and an optional "Save configuration" checkbox persists the form settings to the `user_csv_import.importconfig` config object so they pre-fill next time. The module itself defines no permissions, no Drush commands and no config schema; a bundled submodule (`roleassign_with_user_csv_import`) makes the role list respect the RoleAssign module.

---

- Bulk-create user accounts for a new team from a spreadsheet exported to CSV.
- Onboard a class or cohort of students by importing a roster CSV.
- Migrate simple user lists from another system without writing a migration.
- Assign one or more roles to every imported user in a single operation.
- Import users with custom profile fields (first name, last name, phone, etc.) mapped from CSV columns.
- Set a shared default password for all imported accounts, to be reset on first login.
- Give each imported user a unique password via a `pass` column in the CSV.
- Create imported accounts as Blocked, to activate them later.
- Send the "Welcome (new user created by administrator)" email with a one-time login link on import.
- Skip sending any email while seeding accounts in a staging environment.
- Download a sample CSV template matching exactly the fields you chose to import.
- Handle European-style CSVs by setting the separator to ";".
- Save your preferred import options so repeat imports don't need reconfiguring.
- Automatically de-duplicate usernames by appending a numeric suffix on collision.
- Avoid creating duplicates by skipping rows whose email already exists.
- Populate a `timezone` column so imported users get the right timezone.
- Restrict who can import by relying on the core "Administer users" permission.
- Import editors and grant them an "editor" role in one step.
- Seed demo/test accounts quickly during site building.
- Combine with the roleassign_with_user_csv_import submodule so delegated admins only see roles they may assign.
