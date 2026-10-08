<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Event Logger (cevlogger) — agent index

**What it is:** a standalone, developer-driven database logger. Your code calls the
`cevlogger.logger` service and the message is written to a dedicated `cevlogger_logs`
table. Independent of core dblog; it does NOT subscribe to Drupal's watchdog/logger
channels, so nothing is captured automatically — only messages you explicitly send.

**Version:** 1.0.x (1.0.0-alpha1). Core: `^10 || ^11 || ^12`. Package: Custom.
No dependencies, no composer requirements, no external libraries, no submodules.

**Provides**
- Service `cevlogger.logger` → `Drupal\cevlogger\Service\CevLogger::log(string $module_name, string $type, string $message): void` (args `@database`, `@datetime.time`). See `cevlogger.services.yml`.
- Table `cevlogger_logs` (columns: `id` serial PK, `module_name` varchar(128), `timestamp` int unsigned, `log_type` varchar(64), `log_message` big text; indexes on module_name/timestamp/log_type). Created in `cevlogger_schema()` (`cevlogger.install`), dropped in `cevlogger_uninstall()`.
- Route `cevlogger.content` at `/admin/reports/cevlogger` → `Drupal\cevlogger\Controller\CevLoggerView::viewLogs` (`cevlogger.routing.yml`), gated by `_permission: 'administer site configuration'`. Menu link under Reports (`cevlogger.links.menu.yml`).

**No** own permissions file, no config objects/schema, no config settings/route, no plugins, no hooks, no Drush commands.

**Docs**
- `api/logger-service.md` — the service API, table schema, admin report, install/uninstall.
