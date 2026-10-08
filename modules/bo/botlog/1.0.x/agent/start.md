<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Botlog (`botlog`) — agent index
**Service/API to log bot request events by IP, plus admin ban/white-list screens.**

- **Version:** 1.0.x  | **Core:** ^9.3 || ^10
- **Depends on:** search_api, search_api_solr, system
- **Configure:** `/admin/reports/botlog/monitor` (`botlog.monitor`)
- **Routes:** all under `/admin/reports/botlog/*`, all gated by `administer site configuration` (admin only).
- **Service:** `botlog.helper` (`BotlogHelper`) → `banIp/warnIp/errorIp/whiteListIp`; `botlog.sql` (`BotlogSql`) does DB work with parameterized queries. Drush commands in `Commands/BotlogCmd.php`.

**Security:** no anonymous log-write route (logging is a code-only service API). SQL is parameterized.
