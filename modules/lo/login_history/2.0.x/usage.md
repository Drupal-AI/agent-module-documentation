Login History records one row per successful user login (timestamp, IP address, user agent, and whether it came from a one-time/password-reset link) in a dedicated `login_history` database table, and exposes that data through Views, per-user and site-wide reports, and a "Last login" block.

---

On every successful authentication the module's `hook_user_login()` inserts a row into its own `login_history` base table capturing the user's uid, the login timestamp (from the account's last-login time), the client IP (`hostname`), the truncated `user_agent` string, and a `one_time` flag that is set when the login happened over a one-time login link (route `user.reset.login`). A single configuration value, `keep_user` (default 50), caps how many rows are retained per user: pruning happens both at login time and in `hook_cron()`, and `hook_user_delete()` removes a deleted user's rows. The data is a Views base table (`login_history`) joined to `users_field_data`, and the module ships a default `login_history` view backing the site-wide report at `/admin/reports/login-history`; each user also has `/user/{user}/login-history`. A "Last login" block (`last_login_block`) shows the current user their previous login's host and browser with a link to their own history. Access is gated by three permissions: *view own login history*, *view all login histories*, and *administer login history*. There is no per-login UI beyond the reports; everything is stored as plain table rows, so custom Views, SQL, or the block are the ways to surface it.

---

- Show administrators a site-wide report of who logged in, when, from which IP, and with which browser.
- Let each user review their own login history at `/user/{uid}/login-history`.
- Detect suspicious access by spotting logins from unexpected IP addresses or user agents.
- Flag account-recovery events by filtering on the `one_time` (one-time login link) column.
- Display a "Last login" block so returning users see when and where they previously signed in.
- Cap stored logins per user (e.g. keep the last 50) to bound table growth via the `keep_user` setting.
- Keep unlimited history by setting `keep_user` to 0 for full-audit environments.
- Build a custom View of the `login_history` base table filtered by user, date, or IP.
- Relate users to their logins in Views via the built-in `Logins` relationship on the users table.
- Add a date-range exposed filter over the login timestamp for security investigations.
- Count logins per user with a Views aggregation for engagement or licence-seat reporting.
- Export login history to CSV through a Views data export display for compliance.
- Alert on first-ever login from a new IP/host combination (indexed by `uid, hostname`).
- Prune stale login records automatically on cron once a user exceeds the configured limit.
- Remove a deleted user's login trail automatically to satisfy data-retention rules.
- Provide a lightweight audit trail without enabling a heavier logging/monitoring stack.
- Track one-time-login usage to audit how often password resets are used.
- Surface "You last logged in from …" messaging to reassure users about account security.
- Give a helpdesk read-only visibility into a user's recent login IPs when troubleshooting.
- Feed login timestamps into a custom dashboard using the Views base table.
- Correlate login IPs with geolocation in a downstream report.
- Restrict who can see login data using the three dedicated permissions and roles.
- Show only the current user's own history in the block while admins see everyone's report.
- Distinguish "this browser"/"this IP address" from other devices in the Last login block output.
