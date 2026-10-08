<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Export Profile (config_profile) — agent index

Copies the site's active configuration into an **install profile's `config/install`** directories
as a **side effect of `drush config-export`**. A maintainer/build-time tool for keeping a
distribution or reusable install profile's shipped config in sync with the site it is built on.
Package `Config`. Depends only on core **`config`**. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 2.0.0-beta3. No entities, no plugins, no permissions of its own, no
Drush commands, no runtime request surface.

- **How it works, the settings form, config object + schema, blacklists, `drush cex` flow** →
  [config/settings.md](config/settings.md)

## What it actually is

- **One event subscriber**: `ConfigProfileSubscriber` (`src/EventSubscriber/ConfigProfileSubscriber.php`),
  registered in `config_profile.services.yml` as `config_profile.event_subscriber` with args
  `@extension.list.profile`, `@config.factory`. Subscribes to
  `ConfigEvents::STORAGE_TRANSFORM_EXPORT` → `onExportTransform()`.
- **One settings form**: `\Drupal\config_profile\Form\Settings` (`config_profile_settings`),
  route `config_profile.settings` at `/admin/config/development/configuration/profile`, requirement
  `_permission: 'export configuration'` (a core permission — this module defines none). Local task
  + menu link hang off `config.sync`.
- **One config object**: `config_profile.settings` (schema in `config/schema/`, defaults in
  `config/install/`): `profile` (string, target profile machine name), `blacklist` (sequence of
  config-name glob patterns), `blacklist_property` (sequence of `config.name.property` strings).
- **hook_help** (`config_profile.module`) and `config_profile_update_10001` (adds the
  `blacklist_property` key) — that's the whole module.

## Mechanism (from source)

- On construct, `initializeProfileInfo()` resolves the profile path via
  `extension.list.profile->getPath(profile)`; if the profile isn't found it no-ops. It pre-loads
  the profile's existing `config/install/*.yml` (recursively, via `RecursiveDirectoryIterator`)
  into `profile_config_files`, skipping blacklisted names.
- `onExportTransform()` runs on export only (`STORAGE_TRANSFORM_EXPORT`) and only for the default
  collection. On the first pass it calls `cleanUpConfigDirectory()` which **`unlink`s** every
  pre-loaded profile config file, then for each config name in the export storage: reads the data,
  `unset($data['_core'], $data['uuid'])`, applies `removeBlacklistedProperties()`, and writes YAML
  with `file_put_contents` — over the existing file if the profile already had it, else a new file
  in `<profile>/config/install/<name>.yml` (unless blacklisted).
- `isBlacklisted()` matches a name against `blacklist` patterns with `fnmatch` (glob wildcards).
- `removeBlacklistedProperties()` walks a dotted `config.name.property` path and blanks the leaf
  value (or removes it from a sequence and reindexes).
- Paths are derived from the admin-configured profile name + `DRUPAL_ROOT`; there is **no
  request-supplied path** and the whole thing only fires during an admin/CLI config export.

## Operate it

1. `composer require drupal/config_profile` · `drush en config_profile -y`.
2. Visit `/admin/config/development/configuration/profile` (or Config → Development → Synchronize →
   **Profile** tab); set the target **profile** machine name, optional name/property blacklists.
3. Run `drush config-export` (`drush cex`). Your normal config-sync dir is still written; the
   profile's `config/install` files are additionally overwritten/created. UUIDs and `_core` are
   stripped for portability. See [config/settings.md](config/settings.md).
