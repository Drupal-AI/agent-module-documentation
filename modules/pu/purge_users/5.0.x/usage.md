Purge Users deletes or cancels user accounts that match configurable criteria (never logged in, inactive, blocked, last-login age), either via a global settings form or reusable policy config entities, with optional pre-deletion email notifications. Purging runs on cron (when enabled), via Drush, or manually through a confirmation form.

---

The module offers two ways to define who gets purged. The **global settings form** (`purge_users.settings`, `/admin/config/people/purge-users`) has four independent age-based rules — never-logged-in, last-login older than, inactive/unactivated, and blocked — each with a value + period (minutes/hours/days/…) and an enable checkbox, plus author/commenter exclusions, include/exclude role lists, a Drupal account cancel method (`user_cancel_block`/`_reassign`/`_delete`/site policy), and pre-deletion + deletion notification emails. The newer **policies** (`purge_users_policy` config entities, at `/admin/config/people/purge-users/policies`) let you compose named rule sets from **condition plugins** (`purge_users:never_logged_in`, `:not_logged_in`, `:inactive`, `:blocked`, `:included_roles`, `:excluded_roles`, `:author_commenter`, `:notification_required`), each contributing a query condition against the user table. Matching users are pushed to Drupal **queues** (`purge_users`, `notification_users`) and processed by queue workers; `hook_cron()` enqueues them when `purge_on_cron` is on and also runs `purgeAllUsers()`/`notifyAllUsers()` for policies. Deletion uses core's `user_cancel` methods. Two Drush commands (`purge-users:purge` with `--dry-run`, `purge-users:notify`) and `hook_*_user_ids_alter()` hooks let you script and fine-tune which uids are selected. All admin routes are gated behind `restrict access: true` permissions (`access purge setting page`, `access purge confirmation form`) or `administer site configuration`; every default ships **disabled** (`purge_on_cron: false`, all rule toggles off).

---

- Automatically delete users who registered but never logged in after N days.
- Purge users whose last login is older than a configured threshold.
- Remove accounts that were never activated (inactive) after a period.
- Clean up accounts that have been blocked for longer than a set time.
- Cancel accounts using a chosen method (block, block+unpublish content, reassign content, or delete).
- Exclude users who authored content from being purged.
- Exclude users who have posted comments from being purged.
- Restrict purging to specific roles (include list).
- Protect specific roles from purging (exclude list).
- Email users before their account is deleted (pre-deletion warning), with a configurable lead time.
- Email users a notification when their account is deleted.
- Build named, reusable purge policies from composable condition plugins.
- Combine multiple conditions in one policy (e.g. blocked AND not in "staff" role).
- Run purges automatically on cron (opt-in via "Purge on cron").
- Trigger a purge on demand from the CLI with `drush purge-users:purge`.
- Preview which users would be purged without deleting them (`--dry-run`).
- Queue pre-deletion notifications from the CLI (`drush purge-users:notify`).
- Manually initiate a purge from the confirmation form in the UI.
- Run a policy-specific purge from its own confirmation route.
- Alter the selected user IDs programmatically via `hook_purge_*_user_ids_alter()`.
- Keep GDPR-style data-minimisation by expiring dormant accounts on a schedule.
- Process large purges safely in the background via Drupal queues + queue workers.
- Skip already-blocked users from certain rules via "Disregard inactive/blocked users".
- Re-notify users after they are unblocked (notification flags cleared on unblock).
