<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP Anonymize (ip_anon) — agent index

Enforces an IP-address retention policy: on cron (or `drush ip_anon:scrub`) it scrubs stored
hostnames older than a per-table retention period. Config object `ip_anon.settings`; settings
form at `/admin/config/people/ip_anon` (permission *administer site configuration*). No
permissions of its own, no plugin types.

- **Settings keys, the policy flag, per-table periods, and the config route** →
  [configure/settings.md](configure/settings.md)
- **Drush commands (`ip_anon:scrub`, `ip_anon:policy`)** → [drush/commands.md](drush/commands.md)
- **The `IpAnonymize` service and how `scrub()` works** → [api/service.md](api/service.md)
- **Adding your own table via `hook_ip_anon_alter()`** → [hooks/ip-anon-alter.md](hooks/ip-anon-alter.md)

Key facts:
- `policy`: `0` = preserve IPs (no scrubbing), `1` = anonymize. `hook_cron` only scrubs when
  `policy` is truthy.
- `period_<table>` is an integer of **seconds**; `-1` (or any negative/non-numeric) means keep
  forever / never scrub. Scrub sets the hostname column to `'0'` for rows older than
  `requestTime - period`.
- `sessions` is always covered; other tables are added by `hook_ip_anon_alter()` (comment,
  dblog→`watchdog`, commerce_order, login_history, simple_access_log, tether_stats, visitors,
  votingapi→`votingapi_vote`, webform→`webform_submission`).
