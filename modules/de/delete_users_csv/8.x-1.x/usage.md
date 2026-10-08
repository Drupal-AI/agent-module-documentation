Delete Users CSV adds an admin form that deletes user accounts by email address from an uploaded CSV file.

---

The module ships a single form at `/admin/delete-users-csv` (route `delete_users_csv.upload_file`, requirement `administer users`), linked under People. An administrator uploads a CSV file; the submit handler opens the saved file, reads every row with `fgetcsv()`, and collects any cell value containing `@` as an email address (trimming whitespace and a UTF-8 BOM). It then runs a Batch API job (`DeleteUsersBatch::deleteUsers`) that loads each matching account with the user entity storage `loadByProperties(['mail' => …])` and calls `$user->delete()`, reporting the deleted count when finished. There is no configuration UI, no custom permission, no Drush command, and no dependency beyond Drupal core; the file upload is a core `managed_file` restricted to the `.csv` extension and stored in `public://`. Email matching is column- and row-agnostic, so a plain one-column export or a wider spreadsheet both work as long as the addresses appear literally.

---

- Bulk-remove a list of user accounts by pasting their email addresses into a CSV and uploading it.
- Clean up spam or bot registrations exported from the People page as a CSV.
- Off-board a batch of departed staff by email in one operation instead of cancelling each account by hand.
- Delete accounts identified by an external report (CRM, mailing platform, analytics) exported to CSV.
- Purge addresses that bounced or unsubscribed after exporting them from an email service.
- Remove test or seed accounts created during development by their known email addresses.
- Process a wide spreadsheet where email is only one of several columns — every cell containing `@` is matched.
- Delete accounts from a multi-column export without first trimming it down to a single email column.
- Run a scheduled manual cleanup: export offenders, upload the CSV, confirm the deleted count.
- Reconcile membership after a migration by uploading the emails that should no longer have accounts.
- Enforce a data-retention policy by deleting accounts flagged for removal in a CSV.
- Remove duplicate or merged-away accounts identified by email.
- Delete accounts tied to a decommissioned domain by exporting their addresses.
- Give a user administrator (holding `administer users`) a self-service way to mass-delete without SQL or Drush.
- Handle GDPR/erasure requests for a batch of addresses supplied as a list.
- Quickly empty a staging site of imported real-user emails before go-live.
- Delete accounts named in a support ticket or spreadsheet attachment without manual lookups.
- Use the batch progress and final "N users deleted" status message to confirm how many accounts were removed.
- Combine with a People-page CSV export to build the input file directly from the site.
- Avoid writing a custom script for a one-off bulk user deletion.
