<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credential Mask — masking mechanism, service API, events, Drush

## The event subscriber (runtime entry point)

`EventSubscriber\ConfigEvents` (service `credential_mask.event_subscriber`, arg
`@credential_mask.sensitive_config_manager`) subscribes to core's config **storage-transform** events:

- `ConfigEvents::STORAGE_TRANSFORM_EXPORT` → `onExportTransform()` → `SensitiveConfigManager::mask($storage)`.
- `ConfigEvents::STORAGE_TRANSFORM_IMPORT` → `onImportTransform()` → `SensitiveConfigManager::unmask($storage)`.

The `$storage` handed to these callbacks is the transient export/import storage, **not** active storage — so
mask/unmask rewrite only the config that is being exported to / imported from the sync directory.

## SensitiveConfigManager

Service `credential_mask.sensitive_config_manager`, args `@config.factory`, `@config.storage.active`.
Constants: `MASKING_STRING = '<masked>'`, `SETTINGS_KEY = 'credential_mask.sensitive_config'`.

Constructor loads the editable settings config, converts stored `:` back to `.` in config names
(`array_map`/`array_combine`), and `unset()`s the module's own settings key so it can never be masked.

- **`mask(StorageInterface $storage)`** — for each sensitive config name present in `$storage`, for each
  listed key, if `NestedArray::keyExists()` then `NestedArray::setValue(..., MASKING_STRING)` and write back.
  Replaces the value with the literal `<masked>`; the real value is simply absent from the exported YAML
  (the placeholder is a constant, so it carries no information about the secret).
- **`unmask(StorageInterface $storage)`** — for each sensitive key whose value in `$storage` **equals**
  `<masked>`, read the real value from **active storage** and write it back into `$storage`. This is what
  stops an import of masked YAML from overwriting the live secret. If active storage lacks the value, the
  placeholder is left as-is.
- **`getSensitiveConfiguration($storage = active)`** — expands the list against a storage, resolving `*`
  wildcards in config names. `getWildcardSensitiveConfig()` filters list entries containing `*`, then
  `wildcardToRegex()` = `preg_quote($s, '/')` with `\*` → `.*`, matched against `$storage->listAll()`
  (names only). Non-wildcard entries pass through unchanged.
- **`listExistingSensitiveConfig()`** — intersects the list with what actually exists in active storage.
- **`addSensitiveConfig($configName, $key)` / `deleteSensitiveConfig($configName, $key)`** — mutate the
  settings config (storing the config **name** with `.`→`:`); delete clears the whole entry when its last key
  is removed. **`getSensitiveConfig()`** returns the current in-memory list.

## Drush commands

`drush.services.yml` → `Commands\CredentialMaskCommands` (service `credential_mask.commands`, args
`@credential_mask.sensitive_config_manager`, `@config.storage.sync`). Requires Drush 10 — the `@hook validate`
methods `onImportConfigValidateVersion` / `onExportConfigValidateVersion` return a `CommandError` on
`config:import` / `config:export` when `Drush::getMajorVersion() < 10`.

- `credential_mask:add <configName> <configKey>` — mark a key sensitive (rejects the module's own
  `credential_mask.sensitive_config`). `<configName>` may include `*`; `<configKey>` may be dotted.
- `credential_mask:del <configName> <configKey>` — remove a key from the list.
- `credential_mask:show-configuration` — table of every configured `name` + `key` (the rules, whether or not
  they currently match live config).
- `credential_mask:list` — table of sensitive config that **exists in active storage**, with columns
  `exported` (present in `@config.storage.sync`) and `masked` (its exported value equals `<masked>`). Rows
  that are exported but not masked are rendered with an `<error>` highlight — this is the audit signal that a
  listed secret would leak on the next commit. None of these commands print the secret **value**.

## What it does not do

No encryption, no key store, no environment-variable or Key-module integration, no relocation of secrets:
values stay in Drupal's active (database) config unchanged. The module governs only the exported/imported
config-sync payload. Anything not in the list exports normally.
