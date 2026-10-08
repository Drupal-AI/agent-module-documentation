Enables user-account CUD tracking for Events Log Track: account creation, edits (including role changes and block/unblock), and deletion appear in the audit report with type `user`.

---

`EventLogTrackUserHooks` registers the `user` handler (operations insert/update/delete) and implements `hook_user_insert`, `hook_user_update`, and `hook_user_delete`. The insert entry records the new account's name, uid, assigned roles, and active/blocked status; the update entry compares `$account->getOriginal()` roles to the current roles and records the transition; the delete entry records the removed account. `ref_numeric` holds the uid and `ref_char` the username. Entries go to the parent `event_log_track.manager` service, which supplies actor/IP/time and writes the row. Note this covers the user *entity* lifecycle only — authentication events (login/logout/password reset) are provided by `event_log_track_auth`.

---

- Audit new user registrations and admin-created accounts.
- Track when an account was blocked or unblocked.
- Record role grants and revocations with the before/after role list.
- See who deleted or cancelled a user account.
- Filter the audit report to only `user` events.
- Investigate privilege escalation by reviewing role-change history.
- Trace all changes to a single account by uid (`ref_numeric`).
- Detect bulk account deletions.
- Demonstrate access-governance compliance for user management.
- Correlate account changes with the acting administrator and IP.
- Combine with `event_log_track_auth` for a complete user-activity picture.
- Prune old user-change records automatically via cron retention.
- Exclude specific usernames from logging with the parent skip patterns.
- Export a report of all role changes over a period.
- Identify accounts created and deleted within a short window.
