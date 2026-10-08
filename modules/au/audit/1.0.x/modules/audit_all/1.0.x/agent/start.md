<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit - All (audit_all) — agent index

Meta-module that enables all production-ready audit analyzers at once (excludes the dev-only code-analysis tools).

Submodule of the **audit** framework. Depends on: `audit`, `audit_blocks`, `audit_cache`, `audit_cron`, `audit_database`, `audit_entity`, `audit_fields`, `audit_i18n`, `audit_images`, `audit_menu`, `audit_modules`, `audit_performance`, `audit_security`, `audit_seo`, `audit_status`, `audit_twig`, `audit_updates`, `audit_url`, `audit_views`, `audit_watchdog`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

Meta-module only: **no analyzer plugin, no config, no routes**. Its dependency list enables `audit` plus every production analyzer submodule. Enabling it is equivalent to enabling each listed analyzer.

See the parent framework: [../../../../agent/start.md](../../../../agent/start.md).

Enable: `drush en audit_all`.
