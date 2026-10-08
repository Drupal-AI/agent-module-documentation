Submodule of Admin Audit Trail that logs user account create, update, and delete events into the audit trail under the `user` event type.

---

Part of `admin_audit_trail`. Enabling it registers the `user` event type via `hook_admin_audit_trail_handlers()` and implements `hook_user_insert/update/delete`, each calling `admin_audit_trail_insert()` with `type: user`, an `operation` (`insert`, `update`, `delete`), a description of `"%name (uid %uid)"`, and the account id in `ref_numeric` / display name in `ref_char`. As with the whole suite, the base logger ignores CLI requests, so rows are written for real web-form account changes rather than Drush user operations. View and filter these rows by the `User` type at `/admin/reports/audit-trail`.

---

- Record every user account created through the admin UI.
- Track profile and account edits to see who changed an account.
- Log account deletions for security and compliance review.
- Filter the audit report to the `user` type to review all account activity.
- Reference each entry back to its account via `ref_numeric` (uid).
- See the account name and uid inline in each log description.
- Answer "who created this account?" from the insert-operation rows.
- Answer "who deleted this account?" from the delete-operation rows.
- Correlate account changes with the acting user recorded on each row.
- Correlate account changes with the client IP recorded on each row.
- Pair with `admin_audit_trail_user_roles` to also capture role grants.
- Pair with `admin_audit_trail_auth` to also capture logins and logouts.
- Build a user-management audit trail for regulated environments.
- Distinguish new accounts from edits using `insert` vs `update` operations.
- Keyword-search the report to find all events touching a given username.
- Feed a security dashboard by querying the `user` type rows.
- Keep account-change accountability without custom logging code.
