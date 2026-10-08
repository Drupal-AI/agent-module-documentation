<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio ACSF (sitestudio_acsf) — agent index

Switches **Acquia Site Studio** (Cohesion) generated-asset storage from the **filesystem** to the
**database** (KeyValue), for distributed-filesystem/multisite platforms — notably **Acquia Site
Factory**. Version **1.0.0-beta4**. Core `^9 || ^10 || ^11`, package `Site Studio`.

## Dependencies
- Drupal module: `cohesion_templates` (info.yml `dependencies`).
- Composer: `acquia/cohesion >= 6.3.5` (composer.json `require`). Both are commercial Site Studio parts.

## What it provides
- **Service provider** `SiteStudioAcsfServiceProvider::alter()` (`src/SiteStudioAcsfServiceProvider.php`)
  — aliases `cohesion.template_storage` → `cohesion.template_storage.key_value` (DB-backed Twig templates).
- **Config override** `Drupal\sitestudio_acsf\Config\StylesheetJsonStorageOverride`
  (`src/Config/StylesheetJsonStorageOverride.php`), a `config.factory.override` (priority 5,
  `sitestudio_acsf.services.yml`) — forces `cohesion.settings:stylesheet_json_storage_keyvalue = TRUE`.
- **`hook_install()`** (`sitestudio_acsf.install`) — sets module weight `-100`, rebuilds/reboots the
  kernel, and warns that a Site Studio rebuild is required to migrate templates to the DB.
- **`hook_requirements()`** — adds two status-report rows: template storage and stylesheet JSON storage,
  each shown as Database or Filesystem.

## No UI surface
No routes, no permissions, no forms, no settings, no config schema, no Drush commands, no submodules.
Enabling the module is the entire configuration.

## Operating it
After enabling, run a full rebuild to migrate existing templates: `drush cohesion:rebuild` or
`/admin/cohesion/developer/rebuild`. Expect database size and rebuild/sync load to grow.

## Solution docs
- [config/storage.md](config/storage.md) — the two storage overrides, install behaviour, status report, revert.
