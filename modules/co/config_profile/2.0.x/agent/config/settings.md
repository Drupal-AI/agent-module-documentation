<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Export Profile — settings, config object & the export flow

## Install & enable

```bash
composer require drupal/config_profile
drush en config_profile -y
```

Only dependency is core **`config`** (Configuration Manager). No submodules, no permissions of its
own, no Drush commands, no libraries.

## The settings form

- Class `\Drupal\config_profile\Form\Settings` (`src/Form/Settings.php`), extends
  `ConfigFormBase`, form id `config_profile_settings`.
- Route `config_profile.settings`, path `/admin/config/development/configuration/profile`,
  requirement **`_permission: 'export configuration'`** (core permission; the module defines no
  permissions.yml). Appears as the **Profile** local task and a menu link, both parented to
  `config.sync` (Config → Development → **Synchronize**).
- Three fields, all writing to config object **`config_profile.settings`**:

| Field | Config key | Meaning |
|---|---|---|
| Installation profile | `profile` | Machine name of the profile that active config is exported into. |
| Blacklist (textarea, one per line) | `blacklist` | Config **names** never exported to the profile. Wildcards via `fnmatch` (e.g. `webform.webform.*`, `block.block.*`). |
| Blacklist property (textarea, one per line) | `blacklist_property` | `config.name.property` entries whose value is blanked/removed on export (e.g. `system.site.mail`). |

`submitForm()` splits each textarea on newlines (`preg_split`), drops empty lines with
`array_filter`, and saves reindexed arrays plus the `profile` string.

## Config object & schema

`config/install/config_profile.settings.yml` defaults:

```yaml
profile: ''
blacklist: { }
blacklist_property: { }
```

Schema (`config/schema/config_profile.schema.yml`): `config_profile.settings` is a `config_object`
with `profile` (nullable string), `blacklist` (sequence of strings), `blacklist_property`
(sequence of strings). `config_profile_update_10001` (in `config_profile.install`) initialises the
`blacklist_property` key on sites upgraded from earlier versions.

### Config example

```yaml
# config_profile.settings
profile: my_profile
blacklist:
  - 'webform.webform.*'
  - 'block.block.*'
  - 'core.extension'
blacklist_property:
  - 'system.site.mail'
```

## The export flow (ConfigProfileSubscriber)

Registered in `config_profile.services.yml` as `config_profile.event_subscriber`
(args `@extension.list.profile`, `@config.factory`). Subscribes to
`ConfigEvents::STORAGE_TRANSFORM_EXPORT` → `onExportTransform()`. It runs **only on export**
(`drush config-export` / the UI export), as a side effect of the normal config sync — your site's
configured sync directory is still written; the profile is written *in addition*.

Constructor → `initializeProfileInfo()`:

- Resolves the profile directory with `extension.list.profile->getPath($profile)`. **If the profile
  name is empty or not found, it returns and nothing happens.**
- `profile_config_path` = `<profilePath>/config/install`.
- `loadProfileConfigFiles()` recursively scans that path (`RecursiveDirectoryIterator` +
  `RegexIterator` on `*.yml`) and records each existing config file, keyed by config name, skipping
  names that match the `blacklist`.

`onExportTransform(StorageTransformEvent $event)`:

1. Only acts when a `profile` is set and the storage collection name is empty (default collection).
2. **First pass only**: sets a `cleanup` flag and calls `cleanUpConfigDirectory()`, which
   `array_map('unlink', …)` deletes every pre-loaded profile config file so stale files don't
   linger.
3. For each `name` in `storage->listAll()`: read data, `unset($data['_core'], $data['uuid'])`,
   run `removeBlacklistedProperties($name, $data)`, `Yaml::encode`, then:
   - if the profile already had a file for this name → **overwrite it in place**
     (`file_put_contents` to its original nested location);
   - else if the name is not blacklisted → **create** `<profile>/config/install/<name>.yml`.

Because it overwrites files wherever they already live, config bundled inside modules nested in the
profile (`profiles/x/modules/y/config/install/…`) is updated in the right place, not flattened.

### Blacklist matching

- `isBlacklisted($configName)` → `array_filter($blacklist, fn($p) => fnmatch($p, $configName))` —
  standard shell-glob wildcards.
- `removeBlacklistedProperties()` takes each `blacklist_property` entry, strips the leading
  `config.name.` and walks the remaining dotted key path: it blanks the leaf (`= ''`) when the leaf
  key exists, or, when the token is a **value** inside a sequence, `unset`s it and reindexes the
  array. Unknown paths are skipped.

## Operating notes (from source & README)

- UUIDs and `_core` are stripped, so exported profile config is portable and installable anywhere.
- Only **changed** config (relative to your main config store) is meaningfully exported; to force a
  complete re-export, empty the main config-sync directory first, then `drush cex`.
- Always review where config entities land before committing — putting a config entity in the wrong
  profile directory (`config/install` vs `config/optional`) can break the profile.
- Purely a build/maintenance tool: it fires only during an admin/CLI export and reads its target
  path from admin config (no request-supplied paths, no external calls). Enable it on the
  build/dev environment, not on production distribution instances.
