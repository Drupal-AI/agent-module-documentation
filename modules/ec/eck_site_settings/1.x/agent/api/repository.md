<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading settings: repository service, Twig, tokens, hooks, migration

How code fetches settings singletons. Cites `src/SettingsRepository.php` (+ interface),
`src/Twig/SiteSettingsExtension.php`, `eck_site_settings.tokens.inc`, `eck_site_settings.api.php`,
and `src/ModuleMigration.php`.

## Service: `eck_site_settings.settings_repository`

Class `SettingsRepository` implements `SettingsRepositoryInterface`; also aliased to the interface
FQN for autowiring. Constructor deps: `entity_type.manager`, `entity_type.repository`,
`cache.static`, `language_manager`, `module_handler`.

- `getEntityTypes(): EckEntityTypeInterface[]` — all settings entity types (query on
  `third_party_settings.eck_site_settings.enabled = TRUE`, sorted by label).
- `getBundles(EckEntityTypeInterface): EckEntityBundleInterface[]` — `loadMultiple()` of the type's
  bundle entities (empty if the type has no live definition).
- `isSetting(string $entityTypeId): bool` — is this entity type a settings type (statically cached).
- `getSetting(string $bundle, string $entityTypeId = 'settings', array $context = []): EckEntityInterface`
  — the **lazy singleton loader** (see below).
- `getSettingByClass(string $className, array $context = []): ?EckEntityInterface` — resolves entity
  type + bundle from an entity/bundle class via `entity_type.repository` +
  `storage->getBundleFromClass()`, then delegates to `getSetting()`. Useful with custom ECK bundle
  classes. Throws `\LogicException` if the storage predates bundle classes.

### `getSetting()` mechanics

1. Defaults `context['langcode']` to the current **content** language; sets `entityTypeId`/`bundle`;
   invokes `hook_eck_site_setting_context_alter($context)`.
2. Builds a cache id from the context (excluding langcode) and checks `cache.static`; a cache hit
   loads the entity and returns its current-language translation when present.
3. Otherwise queries the entity type storage (`accessCheck(FALSE)`, `range(0,1)`) filtered by the
   values from `getValues()` — `getValues()` sets the bundle key + langcode and runs
   `hook_eck_site_setting_values_alter($values, $context)` (this is how the domain submodule scopes
   by `field_domain_access`).
4. If no entity matches, `createEntity()` creates and **saves** a new one (title = bundle label);
   otherwise loads the first match. The id is cached (`Cache::PERMANENT`, entity cache tags).
5. Returns the requested-language translation, creating and saving it if missing.

Note: `getSetting()` (and thus the overview and redirect routes, and the Twig/token paths) will
**create-and-save** a singleton on first access — a read can have a write side effect. This is by
design (singletons are materialised on demand), gated by the overview/edit permissions.

## Twig: `site_settings()`

`SiteSettingsExtension` (service `eck_site_settings.twig_extension`, tag `twig.extension`) registers
`site_settings(bundle, entityTypeId = 'settings', context = [])`. Returns the settings entity (or
NULL for an empty bundle arg) after applying the entity's cacheable metadata via a throwaway render,
so template cache contexts/tags are captured. Example:
`{{ site_settings('general').field_tagline.value }}` or, with Twig Tweak,
`{{ site_settings('general').field_body|view }}`.

## Tokens

`eck_site_settings.tokens.inc`:
- `hook_token_info()` registers a token type `eck_site_settings` with one token per
  type/bundle named `<entityTypeId>-<bundle>` (type `settings`).
- `hook_tokens()` resolves `[eck_site_settings:<type>-<bundle>:<field>…]` by loading the singleton
  with `getSetting()` and delegating to the core `settings` entity token generation
  (`Token::findWithPrefix` + `Token::generate`). Bubbleable metadata is passed through.

## Alter hooks (`eck_site_settings.api.php`)

- `hook_eck_site_setting_context_alter(array &$context)` — change which variant loads (e.g. pin
  `langcode`, or add a scoping key). `$context` carries `entityTypeId`, `bundle`, `langcode`.
- `hook_eck_site_setting_values_alter(array &$values, array $context)` — add load/create field
  values (e.g. a custom `title`, or `field_domain_access` for the domain submodule).

## Migration importer: `ModuleMigration`

Service `eck_site_settings.module_migration` (`ModuleMigrationInterface`). Run from a deploy hook
after config import.
- `fromSiteSettings()` — requires `site_settings`; copies each `site_setting_entity_type` bundle,
  its fields (field storage + config, third-party settings), form/view displays (cloned/merged, with
  optional `field_group` handling), and the entity data (incl. translations) into the `settings`
  entity type; then remaps the old `edit site setting entities` →
  `edit any settings entities` and `access site settings overview` permissions.
- `fromWmSettings()` — requires `wmsettings`; flags the existing `settings` type as a setting type,
  drops the enforced `wmsettings` module dependency, moves `wmsettings.settings` key labels/descriptions
  onto the bundle entities, deletes the old config, and remaps permissions.
