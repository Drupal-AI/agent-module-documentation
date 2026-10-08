<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credential Mask (credential_mask) — agent index

Masks configuration values you flag as **sensitive** with the static placeholder `<masked>` in **exported
config-sync YAML**, so credentials/secret keys never land in committed config; transparently restores the
real value on **import**. Package `Config`. Version **1.0.0** (version-dir `1.0.x`). Core
`^8.8.0 || ^9.0 || ^10 || ^11`. License GPL-2.0-or-later. **No module dependencies**; composer `require` is
empty. **Requires Drush 10+**; conflicts with `drupal/config_filter <2` and `drush/drush <10`.

- **Which config is sensitive, the settings form, and the config object** →
  [config/settings.md](config/settings.md)
- **The masking mechanism, service API, storage-transform events, and Drush commands** →
  [api/sensitive-config-manager.md](api/sensitive-config-manager.md)

## What it actually is (from source)

- One event subscriber, `EventSubscriber\ConfigEvents`, subscribed to core's
  `STORAGE_TRANSFORM_EXPORT` (→ `SensitiveConfigManager::mask()`) and `STORAGE_TRANSFORM_IMPORT`
  (→ `SensitiveConfigManager::unmask()`). This is the whole runtime behavior.
- One service, `credential_mask.sensitive_config_manager`
  (`SensitiveConfigManager`, args `@config.factory`, `@config.storage.active`) — reads the sensitivity
  list, masks/unmasks a storage, resolves `*` wildcards in config names.
- One settings form, `Form\SettingsForm` (route `credential_mask.settings` at
  `/admin/config/development/configuration/credential_mask`, permission **`import configuration`**), editing
  the list of `config-name|config-key` pairs. Local task + menu link under `config.sync`.
- Drush commands (`drush.services.yml` → `Commands\CredentialMaskCommands`, requires Drush 10):
  `credential_mask:add`, `credential_mask:del`, `credential_mask:list`, `credential_mask:show-configuration`.
- **No** permissions.yml (reuses core `import configuration`), **no** config schema, **no** plugins,
  **no** entities, **no** JS/CSS, **no** hooks.

## Storage reality (important, not a security hint)

- The sensitivity **list** lives in config `credential_mask.sensitive_config` (config name → array of keys;
  `.` in a config name is stored as `:`). The module never masks its own settings config.
- Masking replaces the value with the constant `SensitiveConfigManager::MASKING_STRING = '<masked>'` **only in
  the storage being exported**. Secret **values stay in Drupal's active (database) config unchanged** — the
  module does not encrypt, relocate, or protect them at rest, and does not provide any env/Key integration.
  It only controls what appears in exported YAML; unlisted keys still export.
