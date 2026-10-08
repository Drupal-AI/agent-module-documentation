<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Upgrade Rector — agent index

Admin UI that runs `drupal-rector` (`palantirnet/drupal-rector`) against installed
projects and surfaces the suggested deprecation-fix patches. Dev/upgrade tool; suggestions
only, never writes to your code. All routes gated by core `administer software updates`.

- **Routes, the run form, where results are stored, the rector exec, patch export, Upgrade
  Status integration, prerequisites** → [configure/run.md](configure/run.md)

Key facts:
- Configure route: `upgrade_rector.run` → `/admin/reports/upgrade-rector`.
- No own permissions file, no config schema, no Drush, no plugins. Requires the rector
  binary at `<webroot>/vendor/bin/rector` or `<project-root>/vendor/bin/rector`.
- Results live in the `upgrade_status_rector_results` key/value collection (shared with the
  Upgrade Status module's report).
