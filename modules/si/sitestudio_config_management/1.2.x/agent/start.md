<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio Configuration Management — agent index

Glue module for Acquia Site Studio (Cohesion) config workflow. No UI/routes/permissions.
Depends on `config_ignore`, `config_split`, `cohesion_sync` (+ `acquia/cohesion` lib). It ships
config defaults on install and hooks Drush `config:export`/`config:import` to run Site Studio
package export/import/rebuild.

- **The Drush post-command hooks + the config-import event subscriber (what runs, when, guards)**
  → [drush/hooks.md](drush/hooks.md)
- **The `site_studio.config_management` service (version tracking, "is configured" gate) and the
  install-time config it writes** → [api/service.md](api/service.md)

Key facts:
- After `config:export` → runs `sitestudio:package:export`. After `config:import` → runs
  `cohesion:import` + `sitestudio:package:import`, plus `cohesion:rebuild` if Cohesion was
  upgraded. All gated by `isSiteStudioConfigured()` (needs `cohesion.settings` `api_key` +
  `organization_key`).
- Install appends `cohesion_*` to `config_ignore.settings`, provides a `config_split`
  `site_studio` (complete_list `cohesion_*`, folder `sitestudio`), and writes
  `cohesion.sync.settings`.
- Commands run through a Symfony Process via `DrushCommandTrait` (`Drush::processManager()`),
  i.e. as separate drush subprocesses; command strings are fixed literals (no user input).
