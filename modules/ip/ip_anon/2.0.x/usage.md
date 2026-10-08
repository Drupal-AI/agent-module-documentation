<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP Anonymize enforces an IP-address retention policy: on each cron run it scrubs stored client IP/hostname values that are older than a configurable per-table retention period.

---

The module keeps a privacy-focused retention policy in the `ip_anon.settings` config. A master `policy` flag (0 = preserve IPs, 1 = anonymize) turns scrubbing on, and a `period_<table>` integer per supported table sets how many seconds an IP may be retained (`-1` = keep forever / never scrub). On `hook_cron()` (and via `drush ip_anon:scrub`) the `IpAnonymize` service loops the known tables and runs an `UPDATE` that sets the hostname column to `'0'` for rows whose timestamp column is older than `requestTime - period`. The core `sessions` table is always covered; other modules register their tables through `hook_ip_anon_alter()` — the module ships handlers for comment, dblog (`watchdog`), commerce_order, login_history, simple_access_log, tether_stats, visitors, votingapi, and webform, each mapping the right hostname + timestamp columns (and an optional cache-reset callback). A settings form at `/admin/config/people/ip_anon` (permission *administer site configuration*) exposes the policy radio plus a retention-period select per table. Two Drush commands exist: `ip_anon:scrub` and `ip_anon:policy`. It cannot guarantee true anonymity (IPs are stored at least briefly and may be logged elsewhere); for stronger measures the README points to the Cryptolog module.

---

- Automatically delete/scrub old client IP addresses to comply with a privacy or GDPR policy.
- Set a short retention window for session-table IPs (e.g. 1 hour) and scrub the rest on cron.
- Keep watchdog (dblog) IPs only long enough to investigate spam, then anonymize them.
- Preserve IPs "forever" for chosen tables (`-1`) while scrubbing others aggressively.
- Temporarily disable anonymization site-wide by flipping the policy radio to "Preserve".
- Scrub IPs on demand from the CLI with `drush ip_anon:scrub` (e.g. after a data-request).
- Review the current retention policy per table with `drush ip_anon:policy`.
- Anonymize IPs stored by Commerce orders after a configurable period.
- Scrub login-history hostnames older than the retention window.
- Clean up IP addresses recorded by the Visitors analytics module.
- Anonymize Voting API vote source IPs after a set time.
- Scrub webform submission remote-address values on a schedule.
- Reduce legal exposure by not retaining stale IP data subject to subpoena.
- Add a custom table to the scrub list via `hook_ip_anon_alter()` in your own module.
- Map a non-standard hostname/timestamp column pair for a custom log table.
- Run anonymization automatically on every cron run without manual intervention.
- Set different retention periods for different data sources on one site.
- Shrink the database footprint of stale IP data over time.
- Provide a per-table retention overview to a compliance stakeholder.
- Integrate IP scrubbing into a scheduled maintenance workflow via Drush.
- Anonymize simple_access_log remote-host values after a retention period.
- Anonymize tether_stats activity-log IPs on a schedule.
- Keep comment field-data hostnames only for a limited spam-review window.
- Enforce a consistent retention period across environments via exported config.
