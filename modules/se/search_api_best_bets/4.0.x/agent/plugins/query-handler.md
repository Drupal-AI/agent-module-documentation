# Plugin type: Best Bets Query Handler

Adapts the matched best-bets item ids into backend-specific search-query changes. Implement one to support a
non-Solr Search API backend.

## Plugin type wiring

- Plugin type id: `search_api_best_bets_query_handler`.
- Discovery dir: `Plugin/search_api_best_bets/query_handler` (in any module).
- Attribute: `Drupal\search_api_best_bets\Attribute\SearchApiBestBetsQueryHandler`.
- Interface: `Drupal\search_api_best_bets\QueryHandler\QueryHandlerPluginInterface`
  (extends `PluginFormInterface`, `ConfigurableInterface`).
- Base class: `Drupal\search_api_best_bets\QueryHandler\QueryHandlerPluginBase`
  (implements `ContainerFactoryPluginInterface`; injects `config.factory`).
- Manager service: `plugin.manager.search_api_best_bets.query_handler`
  (`QueryHandlerPluginManager`; alter hook `hook_best_bets_query_handler_info_alter`).

## Attribute parameters

```php
#[SearchApiBestBetsQueryHandler(
  id: 'my_backend',
  label: new TranslatableMarkup('My backend'),
  description: new TranslatableMarkup('...'),
  backends: ['my_search_api_backend_plugin_id'], // which Search API backend ids this supports
)]
```

The processor's config form only offers handlers whose `backends` include the index server's backend
(`QueryHandlerPluginManager::getAvailableQueryHandlersByBackend()`).

## Methods to implement

```php
// Change the outgoing search query using the matched entities.
public function alterQuery(array $entities, QueryInterface &$query);
// $entities is ['elevate' => [itemId, ...], 'exclude' => [itemId, ...]] (keys present only when non-empty);
// item ids look like "entity:node/123:en".

// Post-process results (e.g. mark elevated items) after the backend responds.
public function alterResults(ResultSetInterface &$results);
// Set $item->setExtraData('elevated', TRUE) on elevated items so theming + score override apply.

// Plus the PluginForm/Configurable methods (buildConfigurationForm, validate, submit,
// getConfiguration, setConfiguration, defaultConfiguration) — the base class provides sane defaults.
```

## Reference implementation

`Plugin/search_api_best_bets/query_handler/Solr.php` (id `solr`, backends `search_api_solr`,
`acquia_search`): in `alterQuery()` it converts item ids to Solr document ids
(`<siteHash>-<index>-<itemId>` via `search_api_solr` `Utility::getSiteHash()`), sets query options
`solr_param_forceElevation=true`, `solr_param_enableElevation=true`, `solr_param_elevateIds`,
`solr_param_excludeIds`, and `solr_param_fl='id,[elevated]'`. In `alterResults()` it reads the Solr response
docs, marks items with `[elevated]` truthy via `setExtraData('elevated', TRUE)`.

The processor calls the handler through `createInstance($plugin_id, [])`, so a handler needs no processor-side
configuration to run; its own configuration form (if any) is embedded by the processor.
