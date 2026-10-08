<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nagios Monitoring — agent index

Exposes a plain-text **status page** (default `/nagios`) for Nagios/Icinga to poll, returning
an OK/Warning/Critical/Unknown health summary. Aggregates built-in checks (cron, watchdog,
maintenance, requirements) plus any module's `hook_nagios()`. Endpoint is **disabled by
default**. Also ships Drush commands. All config is one object: `nagios.settings`.

- **Enable/secure the status page, config keys, settings & ignored-modules forms** →
  [configure/status-page.md](configure/status-page.md)
- **Add your own check (`hook_nagios`, `hook_nagios_info`) and status codes** →
  [hooks/nagios.md](hooks/nagios.md)
- **Drush commands (`nagios`, `nagios-list`, `nagios-updates`)** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Status route `nagios.statuspage` at `<nagios.statuspage.path>/{module_name}/{id_for_hook}`
  (default path `nagios`); controller `StatuspageController::content`; **access requires
  `nagios.statuspage.enabled` = true**.
- Request auth: HTTP `User-Agent` == `nagios.ua` (default `Nagios`), OR `?unique_id=<ua>`
  when `nagios.statuspage.getparam` is true, OR permission `administer site configuration`.
- Settings form route `nagios.settings` at `/admin/config/system/nagios` (perm `administer
  site configuration`); "Ignored modules" form (perm `administer nagios ignore`).
- Status codes are config-driven: `nagios.status.{ok,warning,critical,unknown}` = 0/1/2/3,
  defined at runtime as `NAGIOS_STATUS_OK`/`_WARNING`/`_CRITICAL`/`_UNKNOWN`.
- No plugin types; extension is via hooks. Depends on core `update` module for update checks.
