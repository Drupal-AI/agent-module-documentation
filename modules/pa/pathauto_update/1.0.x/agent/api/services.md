# Services, entity, queues & runtime flow

Pathauto Update has no UI. It stores, per path alias, the entities/configs its Pathauto pattern
tokens depend on, then regenerates the alias when one of those changes. Everything is glued by
`hook_entity_*` in `pathauto_update.module` and two `ConfigEvents` subscribers.

## Services

| Service ID | Class | Role |
|---|---|---|
| `pathauto_update.path_alias_dependency.repository` | `PathAliasDependencyRepository` | CRUD over `path_alias_dependency` rows; queues regenerations. |
| `pathauto_update.path_alias_dependency.resolver` | `PathAliasDependencyResolver` | Given an entity, scans its Pathauto pattern's tokens and collects dependencies via provider plugins. |
| `plugin.manager.pattern_token_dependency_provider` | `PatternTokenDependencyProviderManager` | Plugin manager for token dependency providers (see plugins doc). |
| `pathauto_update.path_alias_dependency_update.subscriber` | `EventSubscriber\DependencyUpdateSubscriber` | On entity/config **save**, regenerates dependent aliases. |
| `pathauto_update.path_alias_dependency_delete.subscriber` | `EventSubscriber\DependencyDeleteSubscriber` | On entity/config **delete**, drops deps (and regenerates aliases that referenced the deleted entity). |
| `pathauto_update.path_alias_update.subscriber` | `EventSubscriber\PathAliasUpdateSubscriber` | On a `path_alias` save, (re)collects and stores that alias's dependencies. |
| `pathauto_update.menu_link_content.subscriber` | `EventSubscriber\MenuLinkContentSubscriber` | On a `menu_link_content` save, re-collects deps of the linked entity's alias (menu tree changed). |

The three subscribers wired into `hook_entity_*` (`DependencyUpdateSubscriber`,
`PathAliasUpdateSubscriber`, `MenuLinkContentSubscriber`) are invoked directly from the module
file, not tagged as `event_subscriber`. `DependencyUpdateSubscriber` and `DependencyDeleteSubscriber`
are also tagged `event_subscriber` for the config `SAVE`/`DELETE` events.

## The `path_alias_dependency` entity

`src/Entity/PathAliasDependency.php` — a `@ContentEntityType` (id `path_alias_dependency`,
base_table `path_alias_dependency`, not translatable, id key `did`). Base fields:

| Field | Type | Meaning |
|---|---|---|
| `did` | integer (read-only) | Primary key. |
| `path_alias_id` | integer | The `path_alias` entity this dependency belongs to. |
| `dependency_type` | string | `entity` or `config` (`PathAliasDependencyInterface::TYPE_ENTITY` / `TYPE_CONFIG`). |
| `dependency_value` | string | For `entity`: `"{entity_type}:{id}:{langcode}"`. For `config`: the config object name. |
| `created` | created | Timestamp. |

No config schema and no config entities — the table is created by the content-entity schema, so
`getDependenciesByType()` matches on the exact `dependency_value` string.

## Repository API (`PathAliasDependencyRepositoryInterface`)

- `addDependencies(PathAliasInterface, PathAliasDependencyCollectionInterface)` — persist a
  resolved collection (one row per entity/config; de-duplicated via `getDependency()`).
- `getDependenciesByType($type, $value)` / `getDependenciesByPathAlias($alias)` — read rows.
- `updatePathAliasesByType($type, $value)` — for every alias that depends on `$type:$value`,
  resolve the alias back to its entity (`url_entity.extractor`) and **queue** a regeneration.
- `deleteDependenciesByType($type, $value, $updateDependentPathAliases = TRUE)` — delete matching
  rows and (by default) regenerate the aliases that referenced them.
- `updatePathAlias(EntityInterface)` — enqueue a `pathauto_update_path_alias_updater` item.
- `queueEntityType(EntityTypeInterface): int` — enqueue every row of the type's data table into
  `pathauto_update_path_alias_dependency_updater` (used by `hook_install`); returns the count.

## Resolver (`PathAliasDependencyResolverInterface::getDependencies(EntityInterface)`)

Loads the entity's Pathauto pattern (`pathauto.generator::getPatternByEntity`), `token->scan()`s
the pattern string, and for each token type that has a matching provider plugin calls
`$provider->addDependencies($tokens, $data, $options, $collection)`. Returns a
`PathAliasDependencyCollection` of dependent entities + configs.

## Queue workers (`src/Plugin/QueueWorker`)

| Queue ID (`::ID`) | Class | `processItem($data)` where `$data = {id, type, language}` |
|---|---|---|
| `pathauto_update_path_alias_dependency_updater` | `PathAliasDependencyUpdater` | Load entity + translation, find its `path_alias`, resolve dependencies, store them. |
| `pathauto_update_path_alias_updater` | `PathAliasUpdater` | Load entity + translation, `pathauto.generator->updateEntityAlias($entity, 'update')`, invalidate its cache tags. |

Both declare `cron = {"time": 30}`, so a normal cron run processes each queue for up to 30s.
See [../drush/queues.md](../drush/queues.md) to drain them manually.

## Runtime flow

1. **Alias created/changed** (`path_alias` save) → `PathAliasUpdateSubscriber` resolves and stores
   that alias's token dependencies.
2. **A dependency changes** (any entity save → `DependencyUpdateSubscriber::onEntityUpdate`; any
   config save → `onConfigUpdate`) → `updatePathAliasesByType()` queues a regeneration for every
   dependent alias.
3. **A dependency is deleted** (entity delete → `hook_entity_delete`; config delete) →
   `DependencyDeleteSubscriber` removes the rows and regenerates the affected aliases.
4. **Menu link saved** → `MenuLinkContentSubscriber` re-collects deps of the linked entity's alias.
5. **Queues drain on cron** → dependency rows get written, aliases get regenerated by Pathauto.

## Install / uninstall (`pathauto_update.install`)

- `hook_install` enqueues dependency collection for all existing `taxonomy_term`, `node`, `media`
  plus every type in `pathauto.settings:enabled_entity_types`, and reports the queued count.
- `hook_uninstall` deletes both queues.
