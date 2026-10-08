<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Expire blocks user accounts automatically — either on a specific date set per user, or after a configurable period of inactivity defined per role — and can email users a warning before their account expires.

---

The module offers two complementary expiration mechanisms. Per-user: with the `set user expiration` permission, a "User expiration" section appears on each user's edit form where you tick a box and pick an expiration date; that date is stored (as a Unix timestamp) in the module's own `user_expire` database table keyed by uid. Per-role: on the settings form (`/admin/config/people/user-expire`) you set, for each role, a number of seconds of inactivity (0 = never) after which accounts holding that role are blocked; "inactivity" means time since last access, or since account creation for users who never logged in. All the actual blocking happens on `hook_cron`: it first sends per-role expiration-warning emails (if enabled), then blocks any per-user accounts whose date has passed, then blocks per-role inactive accounts — blocking sets the account's status to blocked, logs it, and clears the stored per-user date. Warning emails use a configurable subject/body template with tokens, are throttled by a `frequency` setting, and begin an `offset` number of seconds before expiry; a `send_expiration_warnings` flag turns the whole warning system on or off. An "Expiring users" report at `/admin/reports/expiring-users` lists accounts with a pending expiration, Views integration exposes the expiration date as a field/filter/sort, and a Rules action ("Set a user expiration date") lets other automation set expirations. All configuration lives in `user_expire.settings`; three restricted permissions gate the account-edit control, the report, and the settings form.

---

- Expire a contractor's account automatically on the last day of their engagement.
- Set an expiration date on a temporary user so it is blocked without manual follow-up.
- Block accounts in a "Vendor" role after 90 days of inactivity.
- Automatically disable staff accounts that have not logged in for a year.
- Warn users by email a week before their account is due to be blocked for inactivity.
- Turn expiration-warning emails on or off site-wide with a single flag.
- Customise the warning email subject and body using tokens like `[user:display-name]`.
- Control how often warning emails are re-sent (e.g. every 2 days) via the frequency setting.
- Start warning users a configurable number of days before expiry via the offset setting.
- Review all accounts with a pending expiration on the Expiring users report.
- Build a View of users sorted by their upcoming expiration date.
- Filter a user View to accounts expiring within a date range using the exposed expiration filter.
- Grant only trusted admins the ability to set expiration dates via the `set user expiration` permission.
- Expire authenticated users generally by setting an inactivity period on the authenticated role.
- Let a Rules/ECA workflow set a user's expiration timestamp programmatically.
- Reset (remove) a user's expiration by unticking the expiration box on their edit form.
- Keep newly reactivated accounts from being immediately re-blocked (their last-access time is refreshed on unblock).
- Enforce a security policy that dormant accounts get disabled automatically.
- Notify an admin (via the report) which accounts are about to expire before they are blocked.
- Set different inactivity thresholds per role (e.g. stricter for privileged roles).
- Immediately block a user on a chosen future date without writing custom code.
- Use cron to run all expiration and warning processing unattended.
- Audit expirations through the watchdog log entries the module writes when it blocks a user.
