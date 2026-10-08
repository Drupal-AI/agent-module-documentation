<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Overlay — how it works, settings, integrations

Source: `web/modules/contrib/config_overlay/`. No routes, permissions, forms, or Drush commands —
you operate it entirely through the normal core config workflow (`drush config:export` / `cim`,
or admin config sync). Enabling the module is the whole setup.

## Install / enable
```bash
composer require drupal/config_overlay
drush en config_overlay -y
drush config:export -y     # sync dir now holds only diffs vs shipped defaults
```
No settings form and no `configure` route. `hook_install()`
(`config_overlay_install`) records any shipped config already deleted at enable time into
`config_overlay.deleted`.

## Export path — `ConfigTransformSubscriber::removeShipped()`
Runs late on export (default priority `-50`). For every object in the export storage it reads the
matching **shipped** config via the extension storage; if the two are equal (with `_core` and
`uuid` stripped only when the shipped copy lacks them — the `$ignoreKeys` = `['_core','uuid']`),
the object is deleted from the export. Collections are processed with the default collection last
so `core.extension` stays available for other collections. Result: the sync directory contains
only added/modified config.

## Import path — `ConfigTransformSubscriber::overlayShipped()`
Runs early on import (default priority `+50`, the inverse of the export priority). It re-adds all
shipped config that is (a) not present in the sync storage and (b) not listed in
`config_overlay.deleted`, amending each object's `uuid`/`_core` from the active config so the
import detects no false differences. It also reconstructs `language.*` collections for languages
that will exist post-import. Two priority-100 helpers run first on import:
- `ensureCoreExtension()` — if the sync storage has no `core.extension` (site installed from a
  profile that ships it in `config/sync`), it is copied from the profile's `config/sync`.
- `ensureConfigOverlayDeleted()` — likewise seeds `config_overlay.deleted` from the profile's
  `config/sync` then `config/install`.

## Deleted shipped config — `ConfigDeleteSubscriber` + `config_overlay.deleted`
Because deleting a shipped object would otherwise be silently "restored" by the overlay on next
import, deletions of shipped config are tracked:
- `onDelete()` adds the name to `config_overlay.deleted` **iff** the extension storage has that
  name. With Config Ignore 3.x enabled, a deletion ignored on *both* import and export is not
  recorded (so ignored-but-deleted shipped config isn't restored). The guard checks
  `moduleExists('config_ignore') && class_exists(ConfigIgnoreConfig::class)` before using the 3.x
  API — safe with older/absent Config Ignore.
- `onSave()` removes a name from the list when that shipped config is re-created.
- `config_overlay_module_preinstall()/preuninstall()` rebuild the subscriber's extension storage
  when the module list changes so comparisons use the correct extension set.

Config object schema (`config/schema/config_overlay.schema.yml`):
```yaml
config_overlay.deleted:
  type: config_object
  mapping:
    names: { type: sequence, sequence: { type: string } }
```

## Extension storage (what "shipped config" means) — `ExtensionStorageFactory::create()`
Builds a `ReadOnlyUnionStorage` (first match wins) over, in order:
1. the install profile's `config/sync` dir (if any) — lets the profile override module defaults;
2. `ExtensionInstallStorage` for `config/install`;
3. `ExtensionOptionalStorage` for `config/optional` — includes an optional config object only when
   its module/theme/config dependencies are all met (`isValidOptionalConfig()`), mirroring core's
   config installer. `ReadOnlyUnionStorage::write/delete/rename` throw `UnsupportedMethodCallException`.

## Transformation priorities — `ConfigOverlayServiceProvider::alter()`
- Default export priorities `[-50]` (import = inverse `[+50]`).
- If **Config Split** is installed, defaults become `[-50, 50]` so Config Overlay also runs early
  on export / late on import — shipped config isn't split off into stack-able splits and shipped
  splits are detected on initial import.
- Override with `$settings['config_overlay_priorities']` in `settings.php` (list of ints, keep
  them > -100). The legacy `$settings['config_overlay_export_priorities']` is deprecated
  (removed in 3.0). Config Ignore runs even later (priority -100 both directions).

Example (from README, for custom/nested Config Split priorities):
```php
$settings['config_overlay_priorities'] = [50, -50];        // Config Split default
$settings['config_overlay_priorities'] = [70, -70];        // splits pinned above/below ±50
```

## Install-from-config (profiles)
For a profile to install from a Config Overlay export, Config Overlay must be enabled *before*
config import. A profile's `hook_install_tasks_alter()` should call
`config_overlay_install_tasks_alter($tasks, $install_state)` (after `module_load_install`) to
insert the `config_overlay_install_config_overlay` batch task before `install_config_import_batch`.
Note: full site-install support needs the core patch from issue 3056624 ("Dispatch config
transformation event during site install from configuration"); otherwise run a `config:import`
right after install to pick up anything missed.

## Edge cases (from README — inconsequential for most sites)
Because `uuid`/`_core` are ignored when comparing, two Drupal-core behaviours change: a
delete-then-recreate of a shipped object with the same name is seen as an update (or no change)
rather than delete+recreate; and a shipped-config update → uninstall/reinstall → revert is not
detected as a change. Don't use Config Overlay if you rely on those specific core behaviours.

## Compatibility notes
- Config Ignore: 3.x only. Config Split: 2.x only (1.x unsupported — incompatible with Config
  Filter 2.x). Both integrations are covered by the module's own test suite.
