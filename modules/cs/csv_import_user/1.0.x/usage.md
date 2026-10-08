CSV Import Users bulk-creates active Drupal user accounts from an uploaded CSV file via a single admin form.

---

CSV Import Users provides one administrative page at `/admin/config/people/user-import` (route `csv_import_user.import_form`, requiring core's `administer users` permission) where an administrator uploads a `.csv` file and the module creates one enabled user account per data row. The first CSV line is treated as the header; every subsequent row is combined with those headers into an associative array. A row must contain `username` and `email` columns — accounts with an already-existing username are skipped. An optional `role` column assigns a matching role, and the form additionally lets the admin tick which of the site's configured user fields (from `field_config` for the `user` entity) to import, so extra columns map onto real user fields. The special `user_picture` field accepts either the URI of an existing managed file or a location that is fetched and stored as the user's picture. Uploads are limited to the `csv` extension and 5 MB. The module depends on the core User and File modules, ships no configuration, permissions, services, or plugins of its own, and reports per-row success, skips, and warnings through the messenger.

---

- Provision many staff or member accounts at once from an HR or CRM export instead of adding them one by one.
- Stand up a new site's initial user base from a spreadsheet of usernames and email addresses.
- Migrate a simple user list off a legacy system into Drupal without writing a custom migration.
- Onboard a batch of course/students or event attendees supplied as a CSV.
- Create accounts and assign each one a role in the same pass using a `role` column.
- Populate custom user profile fields (e.g. `field_company`, `field_address`) during import by selecting them on the form.
- Attach user pictures in bulk by pointing a `user_picture` column at existing managed-file URIs.
- Import user pictures from remote/download locations, saving each as a permanent managed file.
- Seed a staging or QA environment with realistic user accounts for testing.
- Re-run an import safely to add only new people, since existing usernames are automatically skipped.
- Give site builders a no-code way to load users through the admin UI rather than Drush or the API.
- Prepare demo data sets with named accounts and roles for training or sales demos.
- Bulk-create accounts for a membership drive, then let members set their own password via the standard reset flow.
- Load accounts that will authenticate through an external provider, where a local Drupal record is still required.
- Assign departmental roles to a batch of new hires by including the role machine name per row.
- Fill in address, company, or phone profile fields for imported users in one operation.
- Validate a CSV structure quickly, since malformed rows missing `username`/`email` are reported and skipped rather than aborting the run.
- Keep uploads bounded with the built-in 5 MB and `.csv`-only file checks.
- Batch-import contributors or authors so content can be reassigned to real accounts.
- Create per-region or per-team accounts from separate CSVs, one file at a time.
- Provide a repeatable, spreadsheet-driven account-provisioning step in a site launch runbook.
