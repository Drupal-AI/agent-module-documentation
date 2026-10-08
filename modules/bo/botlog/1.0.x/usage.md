<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Botlog exposes a helper service (`botlog.helper` / `BotlogHelper`) that other code can call to record bot request events against a client IP at four levels (white-listed, warning, temporary ban, permanent ban). It ships admin reporting screens under Reports to list, search, view, ban, white-list, and delete logged IP events.

Use it when you have custom logic (a firewall rule, a honeypot, a rate check) that decides an IP is behaving like a bot and you want a central place to log and act on those decisions.
---
Enable with `drush en botlog`. It declares dependencies on `search_api`, `search_api_solr`, and `system`, so a working Solr-backed Search API is expected. All six routes live under `/admin/reports/botlog/*` and every one is gated by the core `administer site configuration` permission (admin only); the module defines no permissions of its own.

Configuration and monitoring is at `/admin/reports/botlog/monitor` (route `botlog.monitor`). A Drush command class (`src/Commands/BotlogCmd.php`) is provided. Logging is done in code via the service, e.g. `\Drupal::service('botlog.helper')->banIp($ip, $data)` / `warnIp()` / `warnIp()` / `whiteListIp()`; there is no public route that writes log entries.
---
- Record IPs your custom bot-detection logic flags as suspicious.
- Ban an IP permanently from an admin screen.
- Temporarily ban an IP at the 'error' level.
- White-list trusted IPs so they are never treated as bots.
- Search logged events by full or partial IP.
- View a raw dump of a single bot event for debugging.
- Delete individual log entries or purge by IP.
- Redirect flagged bots to an error page via `redirectBadBot()`.
- Check whether the current request IP is white-listed.
- Centralize bot logging from multiple custom modules.
- Feed logged IPs into a Solr-backed Search API index.
- Expire old warning entries via `deleteByTime()`.
- Drive bans from a Drush command in cron or CI.
- Track how many events an IP has accumulated.
- Integrate with a honeypot that calls `warnIp()`.
- Audit which IPs are currently permanently banned.
- Build a lightweight IP reputation table for a site.