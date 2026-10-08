<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge control (purge_control) — agent index

Adds a config-driven pause switch to the **Purge** cache-invalidation pipeline. Two booleans in
one config object drive everything: `disable_purge` pauses purging, `purge_auto_control` lets cron
auto-recover (re-enable) it. Enforcement is a Purge `DiagnosticCheck` plugin (`purge_enabled`) that
reports `SEVERITY_ERROR` while paused, which puts Purge's system "on fire" so no processor drains
the queue. A service, a settings form, and Drush commands set the flags.

Depends on `purge:purge` (composer `drupal/purge ^3.0.0`). PHP `>=8.1`. Core `^10 || ^11`.
Configure route: `purge_control.purge_settings` →
`/admin/config/development/performance/purge/purge-control` (permission `administer site
configuration`). No permissions of its own. Provides Drush commands and config schema. Defines no
plugin type (it supplies one instance of Purge's DiagnosticCheck plugin).

- **The settings form, the two config flags, how the pause is actually enforced, cron auto-recovery,
  setting the flags via Drush/PHP** → [configure/settings.md](configure/settings.md)
- **The `purge-control` / `pc` Drush command and its operations** → [drush/commands.md](drush/commands.md)
- **The `purge_control.purge_control` service and the pre/post-command integration pattern** →
  [api/service.md](api/service.md)

Key facts:
- Config object `purge_control.settings`, keys `disable_purge` (bool, default `FALSE`) and
  `purge_auto_control` (bool, default `TRUE`).
- Service id `purge_control.purge_control`, class `Drupal\purge_control\Services\PurgeControl`.
  Methods: `enablePurge()`, `disablePurge()`, `autoEnablePurge()`, `autoDisablePurge()`,
  `setAutomation(bool)`, `setKillSwitch(bool)`, `isPurgeAutomated()`.
- Enforcement plugin: `PurgeDiagnosticCheck` id `purge_enabled`
  (`src/Plugin/Purge/DiagnosticCheck/PurgeEnabledCheck.php`).
- `hook_cron` (`purge_control_cron`) calls `autoEnablePurge()` — re-enables only when
  `purge_auto_control` is TRUE.
- Route `purge_control.purge_settings`; local task under `system.performance_settings`.
- Drush command `purge-control` (alias `pc`), one `op` argument.
