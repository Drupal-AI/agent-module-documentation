<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Suite (config_suite) — agent index

A small layer of automation on top of Drupal's core configuration management. It adds **no**
import/export UI — the only screen is a two-checkbox settings form at
`/admin/config/config_suite/admin_settings` (permission `administer config suite`). Everything runs
through two event subscribers. **Automatic export** copies each config item into the sync directory
the moment it is saved (listens to `ConfigEvents::SAVE`). **Automatic import** runs a full core
`ConfigImporter` from the sync directory on any request made by a user in the `administrator` role,
but only when the sync directory's mtime is newer than the last config-cache write — so a `git pull`
into the sync folder is applied by loading a page as an admin. It also **disables core's cross-site
UUID check** so a config export from one site can be imported into another with a different
`system.site:uuid` (removes the "Site UUID in source storage does not match the target storage."
error).

Both toggles (`automatic_import`, `automatic_export`) default to **TRUE**, and `hook_install()`
performs a one-time full export of active config (including collections) into the sync directory.
Version **2.0.5**, core `^10.1 || ^11`, no dependencies beyond core. Practical caveat, not a setting:
automating export makes the git diff a record of *every* config save (accidents included), so the
review step effectively moves to your VCS commit — the same tradeoff as `config_auto_export`; where a
team can lock production instead, `config_readonly` removes configuration drift rather than
continuously reconciling it.

- Depends on: core only (`drupal/core: ^10.1 || ^11`). No contrib deps, no libraries, no submodules.
- Core: `^10.1 || ^11`. Package: `Custom`.
- Settings page / `configure` route: **yes** — `config_suite.config_suite_form`.
- Permissions: one — `administer config suite`. Drush: **none**. Plugin types: **none**. Config
  schema: yes (`config_suite.settings`).
- Provides two event subscribers; no controllers, no custom routes beyond the settings form, no
  services other than the subscribers.

## What you'd do → where

- **Turn automatic import/export on or off; the settings form, route, permission and config keys** →
  [configure/settings.md](configure/settings.md)
- **The export/import mechanism, the UUID-check override, the install-time export, exact event hooks
  and storage services** → [api/subscribers.md](api/subscribers.md)

## Key facts (real machine names)

- Route: `config_suite.config_suite_form` → `/admin/config/config_suite/admin_settings`, form
  `Drupal\config_suite\Form\AdminSettingsForm` (form id `config_suite_form`),
  `_permission: 'administer config suite'`, `_admin_route: TRUE`.
- Menu link: `config_suite.config_suite_form` under `system.admin_config_development` (weight 99).
- Permission: `administer config suite`.
- Config object: `config_suite.settings` — keys `automatic_import` (bool, default TRUE),
  `automatic_export` (bool, default TRUE). Schema type `config_object`
  (`config/schema/config_suite.schema.yml`); install defaults in
  `config/install/config_suite.settings.yml` (enforced dependency on `config_suite`).
- Services (both tagged `event_subscriber`):
  - `config_suite.config_subscriber` → `Drupal\config_suite\ConfigSuiteExportSubscriber`
    (arg `@router.builder`), extends core `Drupal\system\SystemConfigSubscriber`; overrides
    `onConfigSave(ConfigCrudEvent)` (auto-export) and `onConfigImporterValidateSiteUUID(ConfigImporterEvent)`
    (`stopPropagation()` + returns TRUE → the cross-site UUID check is disabled). Subscribed events are inherited from
    the parent (`ConfigEvents::SAVE`, `ConfigEvents::IMPORT_VALIDATE`, …).
  - `page_load.config_subscriber` → `Drupal\config_suite\ConfigSuiteImportSubscriber`
    (arg `@config.factory`, unused — class has no constructor), subscribes to
    `KernelEvents::REQUEST` via `checkForRedirection()` (auto-import).
- Hook: `config_suite_help` (`help.page.config_suite`). Install: `config_suite_install()` — message +
  `drupal_flush_all_caches()` + full active→sync export (incl. collections).
- Storage used: `config.storage` (active), `config.storage.sync` (the `config_sync_directory` from
  `settings.php`). Import gate compares `stat(config_sync_directory)['mtime']` vs the `cache_config`
  last-write timestamp from `cache.backend.database`.
