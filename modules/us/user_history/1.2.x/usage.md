User history gives a Drupal site an audit trail of user-account changes that core does not keep. It hooks `hook_user_insert`, `hook_user_update` and `hook_user_delete` and writes an immutable `user_history` content entity for each event, snapshotting the account's base properties — name, hashed password, email, timezone, status, roles, language codes and timestamps — together with which account made the change and a human-readable summary of what differed from the previous record. Records are read-only: the access handler forbids creating, editing or deleting them through the UI, so the trail cannot be tampered with via the CRUD forms.

---

After install you run a one-off Initialise batch (`/user_history/initialise`) to baseline every existing account, then the module records changes automatically from that point on. A settings form at `/admin/structure/user_history/settings` controls whether no-change updates are ignored, an optional cron-driven retention period for those no-change records, and which fields added to the user entity should also be tracked (base fields are always tracked). Additional batch forms archive old records out to private-filesystem files in txt/csv/xml/json and restore them again. Reporting is via two shipped Views: a "History" tab on each user profile (gated by `view user_history entities`, scoped to that account) and an admin-only listing of all records (gated by `administer user_history entities`). A small `ConfigEventsSubscriber` service flags when a tracked-field change requires re-running the Update batch. There are no drush commands and no plugin types.

---

- Baseline all existing accounts after enabling the module via the Initialise batch.
- Record who granted or revoked an administrator role, and when.
- Audit account blocking and unblocking over time.
- Track email-address changes on user accounts.
- Keep an immutable log of user edits for a compliance obligation.
- Show a single account's change history on its profile "History" tab.
- Give auditors a site-wide listing of all account changes.
- Investigate account activity after a suspected compromise.
- Detect unexpected or unauthorised role grants.
- Track changes made to accounts during onboarding or offboarding.
- Also track custom user fields (e.g. department, employee id) by opting them in.
- Ignore no-op user saves so the trail only shows real changes.
- Automatically prune "no change" records older than a set period via cron.
- Archive old history records to private files to bound table growth.
- Restore previously archived history records from a file.
- Record the timezone and language preferences an account had at each change.
- Evidence account-management practices for an ISO/SOC access-control review.
- Identify which administrator last modified a given account.
- Report on role-assignment history across the user base with a custom View.
- Keep a record of the initial email address an account registered with.
- Capture a final snapshot of an account at the moment it is deleted.
- Support periodic access reviews with a queryable change history.
- Export the audit trail to CSV for an external reviewer.
- Build a dashboard of recent account changes using the `user_history` Views base table.
