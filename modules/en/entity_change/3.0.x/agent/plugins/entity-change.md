<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityChange plugin type, manager, and example plugins

Source: `src/Plugin/*`, `entity_change.services.yml`. This module only defines a plugin type and a
manager; it has no `.module`, routes, permissions, or config. Nothing runs unless another module
calls the manager with an entity and its original.

## Install / enable

`drush en entity_change`. No configuration. Node example plugins require the core `node` module to
be enabled (they `use Drupal\node\Entity\Node`), though `node` is not declared as a dependency.

## Plugin type

- **Namespace:** `Plugin/EntityChange` (subdir `src/Plugin/EntityChange/`).
- **Discovery:** PHP attribute `Drupal\entity_change\Plugin\Attribute\EntityChange` (preferred) or
  legacy annotation `Drupal\entity_change\Annotation\EntityChange`.
- **Interface:** `EntityChangeInterface::changed(): bool`.
- **Alter hook:** `hook_entity_change_entity_change_plugin_info(&$definitions)`; cache bin
  `entity_change_entity_change_plugin_plugins` (`EntityChangeManager::__construct`).

### Attribute parameters (`Attribute/EntityChange.php`)

- `id` (string), `label` (`TranslatableMarkup`), `context_definitions` (array, keyed by context
  name — typically `entity` and `original`, both `entity:<type>` `EntityContextDefinition`s),
  `type` (string, default `''`), `deriver` (optional class-string).
- `type` encodes scope: `'*'` or `''` = all; `'node'` / `'node:*'` = all node bundles;
  `'node:article'` = only that bundle.

## Manager API — `EntityChangeManager` (service `plugin.manager.entity_change`)

- `buildInstances(EntityInterface $entity, EntityInterface $original): EntityChangeBase[]` — for
  every definition whose `type` matches the entity (via `isMatchingDefinition()`), calls
  `getApplicableInstance()`; returns the plugins keyed by plugin id whose `applies()` is TRUE.
- `getApplicableInstance(string $pluginName, $entity, $original): ?EntityChangeBase` — instantiates
  the plugin, sets context values `entity` and `original`, returns it only if `applies()`; logs to
  channel `entity_change:manager` and returns NULL on `PluginException`.
- `getMatchedDefinitions(EntityInterface $entity): array` — type-matching definitions **without**
  instantiating (cheap pre-check).
- `isMatchingDefinition(string $type, $entityTypeId, $bundle): bool` — splits `type` on `:`;
  `*` type matches everything, `*` bundle matches all bundles of the type, otherwise both must
  match.

Typical caller flow (in another module's `hook_entity_update`): pass `$entity` and
`$entity->original`, then act on each returned plugin's `changed()`.

## Base class & trait

- `EntityChangeBase` (abstract, `src/Plugin/EntityChangeBase.php`) extends `PluginBase`, implements
  `EntityChangeInterface` + `ContextAwarePluginInterface`. `changed()` reads the `entity` and
  `original` context values, delegates to abstract `hasChanged($new, $old)`, caches the result in
  `$hasChanged`, and on `ContextException` logs to channel `entity_change` and returns FALSE.
  Subclasses must implement `applies(): bool` and `protected hasChanged(EntityInterface $new,
  EntityInterface $old): bool`.
- `EntityChangeTrait::applies()` — generic type/bundle gate from `pluginDefinition['type']`; use it
  so a plugin only fires for its declared entity type/bundle.

## Example plugins (`src/Plugin/EntityChange/`)

- **`NodeJustPublished`** (id `node_just_published`, `type: 'node:*'`): `!$old->isPublished() &&
  $new->isPublished()`.
- **`NodeJustUnpublished`** (id `node_just_unpublished`, `type: 'node:*'`): `$old->isPublished() &&
  !$new->isPublished()`.
- **`ReTitled`** (class `ReTitled`, `type: 'node:*'`): `(string) $new->getTitle() !== (string)
  $old->getTitle()`. Note: in source its attribute reuses `id: 'node_just_unpublished'` and that
  label — an upstream copy/paste bug that collides with `NodeJustUnpublished`'s id.

All three use `EntityChangeTrait` and node `entity`/`original` context definitions.

## Writing a plugin (sketch)

Create `src/Plugin/EntityChange/MyChange.php` in your module, add the `#[EntityChange(...)]`
attribute with `id`, `label`, `entity`/`original` `EntityContextDefinition`s and a `type`, extend
`EntityChangeBase`, `use EntityChangeTrait`, and implement `hasChanged($new, $old)` comparing the
fields you care about.
