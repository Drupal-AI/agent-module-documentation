Auto Unban augments Drupal core's Ban module so IP bans expire automatically after a configurable period instead of lasting forever, with an exponential back-off that lengthens each repeat ban of the same IP.

---

The module decorates core's `ban.ip_manager` service (via `AutoUnbanServiceProvider`) with its own `BanIpManager` subclass and adds two columns to the core `ban_ip` table: `expires` (unix timestamp) and `attempts` (repeat-ban counter). `isBanned()` now returns TRUE only while `expires > now`, so a banned IP is silently let back in once its window passes — no cron or queue is involved, expiry is evaluated live on each request. When an IP is (re)banned, `banIp()` sets `expires = now + seconds * 2^attempts`, where `seconds` is the single admin setting (default 3600 = 1 hour, chosen from a select list at `/admin/config/system/auto-unban`, permission `administer site configuration`). The first ban lasts the base period; each subsequent ban of an IP whose previous ban already expired doubles the duration. The core Ban admin form (`/admin/config/people/ban`) is altered to show Ban count / Expires columns, make them sortable, paginate at 50 rows, and add an "Add indefinitely" button that bans for the maximum 32-bit timestamp (2147483647 ≈ year 2038). On install, all pre-existing bans are set to that far-future timestamp so they stay effectively permanent; on uninstall, already-expired rows are deleted (so core Ban won't resurrect them) and the two columns are dropped. Drush commands `ban`, `unban`, and `banned` mirror this. Note the behaviour change: with this module enabled, a plain ban added through the UI or `banIp()` is now time-limited by default rather than permanent.

---

- Automatically lift IP bans after a set time instead of banning permanently.
- Temporarily ban abusive IPs (e.g. brute-force / flood sources) for an hour, then auto-release.
- Escalate repeat offenders with exponential back-off (1h → 2h → 4h → …) per repeat ban.
- Set the initial ban window site-wide (1 minute up to 1 year) on the settings form.
- Keep legacy/permanent bans permanent — existing bans are preserved at install as far-future.
- Add a genuinely permanent ban from the UI via the "Add indefinitely" button.
- Ban an IP from the command line with `drush ban <ip>` (optionally `--permanent`).
- Un-ban an IP from the command line with `drush unban <ip>`.
- List currently banned IPs (or all, including expired) as JSON with `drush banned`.
- Sort the ban table by IP, ban count, or expiry date in the admin UI.
- Page through large ban lists (50 per page) rather than one huge table.
- See human-readable expiry times ("expired" or a formatted date) in the ban table.
- Run a self-healing ban policy that needs no manual review of the ban list.
- Reduce accidental lockouts of shared/NAT/dynamic IPs by expiring their bans.
- Combine core Ban middleware (fast rejection) with automatic time-based release.
- Migrate an existing core Ban setup to time-limited bans without losing current bans.
- Script ban reporting/monitoring by consuming the JSON output of `drush banned`.
- Give repeat abusers progressively longer bans without hardcoding a schedule.
- Cleanly remove the feature: uninstalling drops the extra columns and expired rows.
