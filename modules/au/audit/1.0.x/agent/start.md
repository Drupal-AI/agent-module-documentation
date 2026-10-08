<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit (audit) — agent index

Pluggable **site-audit framework** for Drupal 10.2/11/12. The base module ships **no checks**; it
defines an `AuditAnalyzer` plugin type and the machinery around it. Each check is a submodule that
registers one analyzer plugin. Version 1.0.11. Core `^10.2 || ^11 || ^12`. Not security-advisory
covered. No external composer requirements; no hard module dependency (submodules depend on `audit`).

Governance/QA tool: analyzers **read** site state to report — they change nothing. Report UI is gated
by the `view audit results` permission; settings by `administer audit configuration` (restricted).

## Plugin type

- Attribute `#[AuditAnalyzer(id, label, description, menu_title, output_directory, weight)]` —
  `src/Attribute/AuditAnalyzer.php`.
- Manager service `plugin.manager.audit_analyzer` = `AuditAnalyzerPluginManager` (discovers
  `Plugin/AuditAnalyzer/*`, alter hook `audit_analyzer_info`).
- Interface `AuditAnalyzerInterface`, base class `AuditAnalyzerBase` (`src/`). Plugins implement
  `analyze()`, `getAuditChecks()`, `buildCheckContent()`; optional `buildConfigurationForm()`,
  `processConfigurationValue()`, `checkRequirements()`. See [plugins/analyzer.md](plugins/analyzer.md).

## Routes & permissions

- `audit.reports` — `/admin/reports/audit` (`view audit results`) — analyzer list + Project Score.
- `audit.reports.detail` — `/admin/reports/audit/{analyzer_id}` — runs the analyzer live, no cache.
- `audit.run_all` — `/admin/reports/audit/run-all` (`view audit results` **+ `_csrf_token`**) — batch.
- `audit.settings` — `/admin/reports/audit/settings` (`administer audit configuration`).
- Controller `Controller\AuditResultsController`. Config `audit.settings`. See
  [config/settings.md](config/settings.md).

## Services, hooks, Drush

- `audit.runner` (`AuditRunner`), `audit.score_storage` (`AuditScoreStorage`, State API),
  `audit.component_builder` (`AuditComponentBuilder`, `Xss::filterAdmin` markup),
  `audit.druscan_client` (`DruscanClient` + interface), `audit.cron_scheduler`
  (`AuditCronScheduler`), `logger.channel.audit`. See [api/services.md](api/services.md).
- Queue workers `AuditRecalculate`, `AuditDruscanSync` (`src/Plugin/QueueWorker/`).
- Hooks: `hook_cron`, `hook_theme` (9 `audit_*` components), `hook_help`,
  `hook_menu_local_tasks_alter`, score/factor preprocess (`audit.module`); update + uninstall
  cleanup (`audit.install`).
- Drush `audit:list` (alias `audit`), `audit:run`, `audit:filters` — JSON, `--filter`, `--fail-on`
  (`src/Drush/Commands/AuditCommands.php`).

## Submodules (26) — each nested at `modules/<sub>/1.0.x/`

Part A (documented here): [audit_all](modules/audit_all/1.0.x/agent/start.md) (meta — enables all
production analyzers), [audit_blocks](modules/audit_blocks/1.0.x/agent/start.md),
[audit_cache](modules/audit_cache/1.0.x/agent/start.md),
[audit_complexity](modules/audit_complexity/1.0.x/agent/start.md) (DEV — phploc),
[audit_cron](modules/audit_cron/1.0.x/agent/start.md),
[audit_database](modules/audit_database/1.0.x/agent/start.md),
[audit_duplication](modules/audit_duplication/1.0.x/agent/start.md) (DEV — jscpd),
[audit_entity](modules/audit_entity/1.0.x/agent/start.md),
[audit_fields](modules/audit_fields/1.0.x/agent/start.md),
[audit_i18n](modules/audit_i18n/1.0.x/agent/start.md),
[audit_images](modules/audit_images/1.0.x/agent/start.md),
[audit_menu](modules/audit_menu/1.0.x/agent/start.md),
[audit_modules](modules/audit_modules/1.0.x/agent/start.md).

Part B (documented separately, same tree layout): audit_performance, audit_phpcs (DEV),
audit_phpstan (DEV), audit_phpunit (DEV), audit_search_api (needs search_api), audit_security,
audit_seo, audit_status, audit_twig, audit_updates, audit_url, audit_views, audit_watchdog.

## Solution docs

- [plugins/analyzer.md](plugins/analyzer.md) — the AuditAnalyzer plugin type and how to write one.
- [config/settings.md](config/settings.md) — `audit.settings`, the settings form, DruScan config.
- [api/services.md](api/services.md) — runner, score storage, cron scheduler, queue workers, Drush.
