<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush integration

This module adds **no new Drush commands**. It attaches Drush **command hooks** and a config
event subscriber that chain Site Studio operations onto core config commands. Everything is
gated by `SiteStudioConfigManagement::isSiteStudioConfigured()` (TRUE only when
`cohesion.settings` has both `api_key` and `organization_key`); otherwise it logs a warning and
skips.

## `@hook post-command config:export` — `PostConfigExportHook`
After `drush config:export` succeeds, queues and runs:
- `sitestudio:package:export`

## `@hook post-command config-import` — `PostConfigImportHook`
After `drush config:import`, queues and runs in order:
- `cohesion:import`
- `sitestudio:package:import`
- `cohesion:rebuild` — **only if** `isSiteStudioUpgraded()` (current Cohesion version >
  the version recorded in state). On success after an upgrade, `initialize()` re-stores the
  current version.

## `ConfigEvents::IMPORT` subscriber — `ConfigImportEventSubscriber::onConfigImport`
Covers the case the post-command hook misses (e.g. installing a site from existing config where
`config:import` fires the event but not the post-command in the same way):
- Returns early if the comparer is a `CohesionStorageComparer` (avoids recursion), or if Site
  Studio is not configured.
- If **not** in an installation attempt AND `sitestudio_config_management` is among the modules
  being installed, runs `cohesion:import` + `sitestudio:package:import`.

## How commands are executed (`DrushCommandTrait`)
`addCommand($string)` accumulates literal command strings; `execute()` runs each via
`Drush::processManager()->drush(self alias, $command)` as a **subprocess**, stopping at the first
failure. Command strings are hard-coded literals — there is no external/user input concatenated
into them. Output is streamed and logged to the `sitestudio_config_management` logger channel.
