# index_now_commerce — indexer plugins

The submodule registers two `#[IndexableEntity]` plugins in `Plugin/EntityIndexer/`. Both are empty
subclasses of the parent's `AbstractEntityOperations` — the attribute is the whole configuration.

## `CommerceProductIndexer`

```php
#[IndexableEntity(
  id: 'commerce_product',
  bundleConfigKey: 'exclude_commerce_product_types',
  eventConfigKey: 'exclude_commerce_product_events',
  label: new TranslatableMarkup('Products types'),
)]
class CommerceProductIndexer extends AbstractEntityOperations implements EntityOperationsInterface {}
```

## `CommerceStoreIndexer`

```php
#[IndexableEntity(
  id: 'commerce_store',
  bundleConfigKey: 'exclude_commerce_store_types',
  eventConfigKey: 'exclude_commerce_store_events',
  label: new TranslatableMarkup('Stores types'),
)]
class CommerceStoreIndexer extends AbstractEntityOperations implements EntityOperationsInterface {}
```

## Behavior & configuration

- The base module's `EntityActions` (`hook_entity_insert/update/delete`) and
  `EntityIndexerManager` discover these automatically — no hooks or services in this submodule are
  required for them to work.
- Pings use the entity's absolute canonical URL and follow the same indexability rules as any
  indexer (CLI/`cli_mode` gate, anonymous-view check on insert, excluded bundles/events). See the
  parent's `plugins/entity-indexer.md`.
- **Config keys** (`index_now.settings`, written by the parent settings form's auto-generated tabs):
  `exclude_commerce_product_types`, `exclude_commerce_product_events`,
  `exclude_commerce_store_types`, `exclude_commerce_store_events`. This submodule ships no config
  schema of its own.

## Deprecated / legacy (removed in 4.0.0)

Everything below is `@deprecated` in 3.1.6 and now a no-op or superseded by the plugins above — do
not build on it:

- `index_now_commerce.module`: `hook_form_index_now_settings_alter` (delegated to
  `ModuleSettingsFormAlter`, which no-ops if the plugin-generated `commerce_*` sections already
  exist), and the `path_alias` insert/update hooks (now empty — path-alias pings are handled by the
  base module).
- `CommerceProductOperations` — replaced by `CommerceProductIndexer`.
- `Hook\Alter\Form\ModuleSettingsFormAlter` — the settings form now generates the commerce tabs via
  plugin discovery.
