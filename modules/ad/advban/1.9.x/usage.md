<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Ban is a drop-in replacement for core's Ban module that blocks visitors by IP address, adding IPv4 range bans, per-ban expiry dates, a free-text ban reason, a protected (allow-listed) IP list and bulk unbanning.

---

The module stores bans in its own `advban_ip` database table (`iid`, `ip`, `ip_end`, `expiry_date`, `reason`) and enforces them with an HTTP middleware (`advban.middleware`, priority **250**) that runs *before* page caching, so a banned client can never be served a cached page. On every request the middleware asks `advban.ip_manager` whether the client IP is *protected* first — protected always wins — and only then whether it is banned; a banned request gets a plain `403` response whose body is rendered from the configurable `advban_ban_text` / `advban_ban_expire_text` templates (`@ip`, `@expiry_date` placeholders). A range ban is stored as two `ip2long()` integers in `ip`/`ip_end` and matched with a numeric BETWEEN, so ranges are **IPv4 only**; single bans are stored as the literal IP string. Expiry durations are free-form `strtotime()` strings kept as a newline-separated list in `advban.settings.expiry_durations` (defaults `+1 hour`, `+1 day`, `+1 week`, `+1 month`, `+1 year`, written lazily on first use) plus the sentinel `never`. `hook_cron()` calls `unblockExpiredIp()` which deletes rows whose `expiry_date` is in the past and logs the count. The protected list (`advban_protected_ips`) accepts plain IPs, CIDR blocks, reverse-DNS host suffixes (e.g. `googlebot.com`) and `#` comments. Everything lives behind a single permission, `advanced ban IP addresses`, under `/admin/config/people/advban` (list, search, edit, delete, delete-all and settings tabs). On install it migrates any existing rows from core's `ban_ip` table with the reason "Migrated from Ban".

---

- Ban a single abusive IP address from the whole site with a 403 response.
- Ban a whole IPv4 range (e.g. a hosting provider's block) with a start and end address.
- Give a ban an expiry date so the visitor is automatically unbanned after an hour/day/week.
- Record *why* an IP was banned in the free-text reason field for later auditing.
- Automatically expire and delete stale bans on cron without manual cleanup.
- Protect your office or monitoring IP range so it can never be banned by accident.
- Allow-list search-engine crawlers by reverse-DNS suffix (`googlebot.com`) in the protected list.
- Allow-list a CIDR block such as `198.51.100.0/24` for a partner network.
- Replace core's Ban module while automatically importing its existing banned IPs.
- Show a custom "you have been banned" message including the offending IP.
- Show a different message that also states when the ban expires.
- Bulk-delete every ban, or only the range bans, or only the ones with an expiry date.
- Search the ban list for a specific IP, including finding which range ban covers it.
- Programmatically ban an IP from a spam-detection module via the `advban.ip_manager` service.
- Tag programmatic bans with reporter metadata (`setMetadata()`) so the reason reads `reporter:id`.
- Query whether a given IP is currently banned before taking another action.
- Look up an existing ban by its reason string (e.g. a case number) with `isBannedByReason()`.
- Rate-limit repeat offenders by re-banning with a longer default expiry duration.
- Set a site-wide default ban duration so admins do not have to pick one each time.
- Make the ban form remember the last duration used (`save_last_expiry_duration`).
- Customise how ranges are printed in the admin list (`@ip_start ... @ip_end`).
- Paginate (or disable pagination on) a very long ban list via the listing-rows setting.
- Delegate ban management to a support role with the `advanced ban IP addresses` permission.
- Block a botnet subnet during an incident and let it lift itself after 24 hours.
- Audit current bans and their statuses (Active / Expired / Protected) from the admin list.
- Deploy a standard protected-IP list across environments through `advban.settings` config.
