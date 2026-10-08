<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autoban automatically bans IP addresses by scanning Drupal's watchdog (dblog) log table for matching log entries and, when a rule's threshold is exceeded, handing the offending IPs to a ban provider (core Ban by default).

---

Autoban works from **rules**, each a small `autoban` config entity that says: match dblog rows of a given log **type** (e.g. `page not found`) whose **message** matches a pattern, optionally filtered by **referer** and by **user type** (anonymous/authenticated/any), within a relative time **window** (e.g. "1 hour"); if the same IP appears at least **threshold** times, ban it via the chosen **provider**. Matching uses either `LIKE` or `REGEXP` (a global `autoban_query_mode` setting) and can auto-append wildcards. Bans are executed by pluggable **ban providers** — services tagged `ban_providers` implementing `AutobanProviderInterface`; the submodule `autoban_ban` supplies the `ban` provider (core Ban, single IP), `autoban_advban` supplies `advban` and `advban_range` (Advanced Ban, single and CIDR range). Rules run on **cron** (`autoban_cron`), on **every request** in force mode (`autoban_force_mode`), from the admin **rules list** (`/admin/config/people/autoban`), or via the Drush command `autoban:ban`. Supporting screens include an **Analyze** page that suggests rules from current log noise, a **Test** page that previews which IPs a rule would ban, a global **whitelist** of never-ban IPs, and (via `autoban_dblog`) extra "ban this IP" action links injected into the core **Recent log messages** report. All configuration is exportable config: the `autoban.settings` object plus one `autoban.autoban.<id>` per rule.

---

- Auto-ban IPs that trigger repeated `page not found` (404) errors, e.g. vulnerability scanners probing for `/wp-login.php`.
- Ban IPs generating many `access denied` (403) log entries.
- Throttle brute-force login attempts by banning IPs with repeated failed-login watchdog messages.
- Create a rule that bans an IP after N matching log entries within a rolling time window (e.g. 10 in 1 hour).
- Match only anonymous-user log entries so authenticated staff are never caught by a rule.
- Use a `REGEXP` query mode to match a family of malicious request paths in one rule.
- Ban IPs by referer pattern (e.g. spam referrers appearing in the log).
- Run all ban rules automatically on cron without manual intervention.
- Enable force mode to evaluate rules on every request for near-real-time banning.
- Ban a specific IP or list of IPs immediately from the admin UI via a chosen provider.
- Preview a rule with the Test page to see exactly which IPs it would ban before enabling it.
- Use the Analyze page to auto-suggest new rules from the noisiest current log messages.
- Maintain a whitelist of office/CDN IPs that must never be banned.
- Exclude noisy but harmless dblog types from analysis (`autoban_dblog_type_exclude`).
- Ban single IPs through core Ban (`ban` provider) with no extra infrastructure.
- Ban whole CIDR ranges through Advanced Ban (`advban_range` provider) for aggressive actors.
- Trigger banning of all rules from a cron job or deploy script with `drush autoban:ban`.
- Ban only the IPs of one specific rule with `drush autoban:ban <rule_id>`.
- Add one-click "ban this IP" links to the core Recent log messages report (autoban_dblog).
- Bulk-delete every autoban rule with the Delete all screen.
- Export ban rules as configuration and deploy them across environments.
- Tune the offered threshold and time-window option lists site-wide from the settings form.
- Set a default provider and time window so new rules pre-fill sensibly.
- Debug rule matching by enabling `autoban_debug` to log what each rule query matched.
- Distinguish manual rules from automatic (cron) rules via the rule type.
- Protect a site behind a reverse proxy by banning at the application layer based on logged client IPs.
- Write a custom ban provider (tagged `ban_providers`) to integrate a firewall or external blocklist.
