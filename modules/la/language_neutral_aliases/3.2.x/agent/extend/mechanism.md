# How language neutrality is enforced

The module overrides core's per-language alias behaviour in three coordinated pieces. There
is nothing to configure — enabling the module is the whole switch.

## 1. Repository decorator — neutral lookups

`language_neutral_aliases.services.yml` registers
`language_neutral_aliases.repository_decorator` (class `AliasRepositoryDecorator`) that
**decorates `path_alias.repository`** at `decoration_priority: 9`. It extends core
`AliasRepository` and overrides every lookup to pass `LanguageInterface::LANGCODE_NOT_SPECIFIED`
instead of the request language:

- `preloadPathAlias($preloaded, $langcode)` → always `und`
- `lookupBySystemPath($path, $langcode)` → always `und`
- `lookupByAlias($alias, $langcode)` → always `und`
- `pathHasMatchingAlias($initial_substring)` → queries with `base_table.langcode = und`

So alias resolution ignores the active language entirely.

## 2. Storage + list-builder swap — neutral writes & listing

`language_neutral_aliases.module` implements `hook_entity_type_alter()` to reassign the
`path_alias` entity type's handlers:

- **Storage class →** `NeutralPathAliasStorage` (extends core `PathAliasStorage`). Its
  `create()` sets the new entity's `langcode` to `und`; its `save()` forces `langcode` to
  `und` before saving if it is anything else. **Result: every alias is stored neutral**,
  even if a specific langcode was requested.
- **List builder →** `NeutralPathAliasListBuilder` (extends `PathAliasListBuilder`), whose
  `getEntityIds()` adds `condition('langcode', und)` so the URL-aliases admin page lists
  only neutral aliases.

## 3. Hook ordering — win over `path` and stop per-translation aliases

`hook_module_implements_alter()` does two things:

- For `entity_type_alter`, it moves this module's implementation to run **last**, so its
  list-builder/storage override wins over the `path` module's.
- For `entity_translation_create`, it **unsets** the `path` module's implementation, which
  otherwise creates a separate alias per translation — the source of duplicate/conflicting
  aliases this module exists to prevent.

## Legacy aliases & caveats

- Aliases that already exist with a non-`und` langcode become effectively **hidden**: they
  won't resolve, won't show on node edit, and won't appear in the admin list — but are not
  deleted, so uninstalling the module restores them.
- For permanent use, clean up or bulk-convert legacy rows:
  `UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';`
- With translated content the **"URL alias" field must not be translated** — a single
  neutral alias per entity cannot be expressed as per-translation values.
