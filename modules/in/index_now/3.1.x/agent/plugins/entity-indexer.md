# index_now — EntityIndexer plugin type

Index Now defines an **attribute-based plugin type** that decides which entity types get pinged.
Add one plugin and your entity type is covered — no hooks, services, or form alters needed.

## The pieces

- **Manager:** `index_now.entity_indexer_manager` (`EntityIndexerManager` extends
  `DefaultPluginManager`). Discovers plugins in any module's `Plugin/EntityIndexer/` directory,
  interface `EntityOperationsInterface`, attribute `IndexableEntity`. Alter hook:
  `hook_index_now_entity_indexer_info_alter`. Cache key `index_now_entity_indexer_plugins`.
  - `getIndexerForEntityType(string $id): ?EntityOperationsInterface`
  - `getIndexedEntityTypeIds(): string[]`
  - `getDefinitions()` — used by the settings form to build a tab per type.
- **Attribute:** `#[IndexableEntity]` (`Drupal\index_now\Attribute\IndexableEntity`) with:
  - `id` — the entity type id it handles (also the plugin id), e.g. `node`.
  - `bundleConfigKey` — `index_now.settings` key for excluded bundles, e.g. `exclude_node_types`.
  - `eventConfigKey` — key for excluded events, e.g. `exclude_node_events`.
  - `label` — optional human label (shown as the settings-form tab title).
- **Base class:** `AbstractEntityOperations` (implements `EntityOperationsInterface`,
  `ContainerFactoryPluginInterface`). Provides the whole ping pipeline; a concrete indexer is
  usually an empty subclass carrying the attribute.

## Built-in indexers

- `NodeIndexer` — `id: node`, `exclude_node_types` / `exclude_node_events`.
- `TermIndexer` — taxonomy terms.
- (submodule) `CommerceProductIndexer`, `CommerceStoreIndexer`.

## Register a new indexable entity type

```php
namespace Drupal\my_module\Plugin\EntityIndexer;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\index_now\AbstractEntityOperations;
use Drupal\index_now\Attribute\IndexableEntity;
use Drupal\index_now\EntityOperationsInterface;

#[IndexableEntity(
  id: 'my_entity',
  bundleConfigKey: 'exclude_my_entity_types',
  eventConfigKey: 'exclude_my_entity_events',
  label: new TranslatableMarkup('My entity'),
)]
class MyEntityIndexer extends AbstractEntityOperations implements EntityOperationsInterface {}
```

Add the two config keys to your entity's schema/config so the excludes persist. The settings form
auto-renders a tab; `EntityActions` (core `hook_entity_insert/update/delete`) routes matching
entities to your indexer.

## How a ping is decided (`AbstractEntityOperations`)

`pingIndexNow($entity, $event)` → checks the entity type matches the attribute `id`, then
`pingEntityIndexNow()` → takes the translation from context, and if `isEntityIndexable()`:

- CLI + `cli_mode` off → not indexable.
- event `insert` + anonymous user cannot `view` the entity → not indexable.
- event in the excluded-events config → not indexable.
- bundle in the excluded-types config → not indexable.

Then builds `Url::fromRoute("entity.{type}.canonical", ..., ['absolute' => TRUE, 'language' => …])`
and calls `index_now.indexnow->sendRequest($url, ['entity' => $entity])`.

## Customization hooks in the base class

`getRouteName()`, `getRouteParameter()`, `buildEntityUrl()`, `getEntityBundle()` are `protected`
and overridable if your entity's canonical URL doesn't follow the `entity.{type}.canonical`
convention. Overriding `getExcludeEventsConfigKey()` / `getExcludeTypesConfigKey()` is deprecated —
prefer the attribute (removed in 4.0.0).
