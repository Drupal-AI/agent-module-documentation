<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Force Password Change lets administrators require users to change their password — by role, per individual user, on first login, or automatically after a configurable expiry period — enforced on the user's next page load or next login.

---

The module adds a settings form at `/admin/config/people/force_password_change` (route `force_password_change.admin`, permission `administer force password change`) plus per-role detail pages. Its persistent state lives in two places: a `force_password_change.settings` config object (keys `enabled`, `check_login_only`, `first_time_login_password_change`, `expire_password`, `installation_date`, plus `expiry_data`/`roles_change_password` sequences) and three custom database tables (`force_password_change_roles`, `force_password_change_expiry`, `force_password_change_uids`). A pending force for an individual user is stored via the core `user.data` service under module `force_password_change` (`pending_force`, `last_force`, `last_change`). When `check_login_only` is FALSE, an HTTP middleware (`force_password_change.on_only_login`) and event subscriber check for a pending force on every page load and redirect the user to their edit form; when TRUE the check runs only in `hook_user_login()`. Admins trigger a force by ticking a checkbox on the settings form (per role), the role edit form, or a user's profile edit form — these are "triggers", not persisted checkbox states. Password expiry compares each user's last change/created time against the highest-priority (weighted) role expiry rule. The whole module can be disabled without uninstalling by setting `$config['force_password_change.settings']['enabled'] = FALSE;` in `settings.php`, useful if it locks you out.

---

- Force every user in the "authenticated" role to change their password immediately after a suspected breach.
- Require a single named user to reset their password on their next page click from their profile edit page.
- Make all newly created accounts change their admin-set password on first login (site-wide `first_time_login_password_change`).
- Force just one new user (during account creation) to change their password on first login, without the site-wide setting.
- Expire passwords for the "editor" role after 90 days so stale credentials are rotated automatically.
- Set different expiry periods per role (e.g. admins every 30 days, authenticated every year) with weighted priority.
- Switch enforcement between "every page load" (most secure) and "on login only" (less overhead) via `check_login_only`.
- Temporarily disable all enforcement during an emergency by editing `settings.php` instead of uninstalling.
- Force a password change for a role right before an audit to satisfy a compliance requirement.
- View, per role, how many users have a pending forced change on the settings page.
- Drill into a role's detail page to see each user's last force / last change timestamps.
- Redirect a signed-in user back to the page they wanted after they complete a forced change.
- Prevent users from re-using their current password when they complete a forced change (validation blocks it).
- Roll out a mandatory password reset to a newly created "contractor" role.
- Track when each user last had their password forced and last actually changed it (via `user.data`).
- Clear a role's tracking rows automatically when the role is deleted.
- Enforce credential rotation policy on a membership/subscription site.
- Programmatically force a change for specific UIDs from custom code via `force_password_change.service`.
- Force password change for all active users at once via the service (empty UID list forces all).
- Combine expiry with first-time-login enforcement so new accounts start fresh and rotate on schedule.
- Ensure imported/migrated user accounts must set a new password before using the site.
- Add a mandatory reset step for users flagged by an external security tool.
- Give a helpdesk the ability to flag "force change" on any user's edit form (needs `administer force password change`).
- Provide auditors with per-role statistics on outstanding pending password changes.
- Apply a stricter, higher-priority expiry rule to privileged roles that overrides the authenticated-user default.
