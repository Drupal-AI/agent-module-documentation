<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Plus — behaviour reference

Source: `config_plus.module`, `src/ConfigInstaller.php`,
`src/EventSubscriber/ConfigEntityInstallValidationSubscriber.php`,
`config_plus.services.yml`, `config_plus.install`.

## Installer service — `config_plus.config_installer`

Class `Drupal\config_plus\ConfigInstaller`.

```php
\Drupal::service('config_plus.config_installer')
  ->installConfig($type, $extension_name, $prefix = '');
```

- `$type` — extension type (`'module'`, `'theme'`, `'profile'`).
- `$extension_name` — machine name of the extension whose config files to read.
- `$prefix` — optional config-name prefix filter (`''` = all config in the dirs).

Flow (`installConfig()`):

1. Resolves the extension path via `extension.path.resolver` and reads YAML from both
   `config/install/` and `config/optional/` using `FileStorage` in the default collection.
2. Dependency-sorts the found config names with `ConfigDependencyManager::sortAll()`.
3. For each name: builds a `Config` object, sets its data, and (default collection) stamps
   `_core.default_config_hash = Crypt::hashBase64(serialize($data))`.
4. Resolves the entity type via `config.manager`, computes the entity ID, and **only if the
   config name does not already exist in active storage** creates the entity with
   `createFromStorageRecord()`, adding the site langcode, then `->trustData()->save()` when the
   entity `isInstallable()`. A `trigger_error(E_USER_WARNING)` fires if the config name and the
   resulting entity ID disagree.
5. Calls `rewriteConfigs()`.

Limitations / notes:
- Only config **entities** are handled (`getEntityTypeIdByName()` must resolve a type). Plain
  simple-config objects with no entity type are not created by this service.
- Only the **default** config collection is supported.
- Existing active config is never overwritten by steps 1–4 (guarded by
  `configStorage->exists($name)`).
- `trustData()` bypasses config-schema validation on save — the same trust model Drupal core's
  own module-install uses for a module's shipped config.

### config_rewrite integration (`rewriteConfigs()`)

- No-op unless the `config_rewrite` module is installed (constructor args
  `@?config_rewrite.config_rewriter` / `@?logger.channel.config_rewrite`; null when absent).
- For each installed module, scans `config/rewrite/*.yml` (non-recursive) and, **only for the
  config names just installed**, deep-merges the rewrite onto the current active config via
  `config_rewrite.config_rewriter->rewriteConfig()`, strips the `config_rewrite` control key,
  preserves the original `uuid` + `_core` keys unless `config_rewrite_uuids` is set, saves, and
  logs a notice. YAML is parsed with `Symfony\Component\Yaml\Yaml::parse` from trusted
  module-shipped files (no object instantiation).

## Save-time validation subscriber

`ConfigEntityInstallValidationSubscriber::onSave()` subscribes to `ConfigEvents::SAVE`.

- For a saved config whose name maps to a config-entity type that has a `uuid` key: if
  `$config->get($uuid_key)` is empty, it throws
  `ConfigException('Please use the config entity API to install the new config entity "…".')`.
- This is a **post-save** detector, not a preventer (per the README notes): the intent is to
  make a developer aware they saved a config entity through the config factory instead of the
  config entity API (which would leave the entity without a UUID). It has no effect on
  simple-config saves or on entities that carry a UUID.

## Missing-UUID fixer

`config_plus_fix_missing_uuids()` — called from `config_plus_install()` (hook_install), and
callable directly. For every config-entity type with a `uuid` key, loads all entities; for any
with an empty UUID it removes stale `uuid:`-prefixed entries in the
`QueryFactory::CONFIG_LOOKUP_PREFIX.<entity_type>` key-value store, then sets a generated UUID
through `configFactory->getEditable()->save()` (not the entity API — because a preSave constraint
forbids changing an entity UUID directly), resets the storage cache for that ID, and logs an
`info` message.
