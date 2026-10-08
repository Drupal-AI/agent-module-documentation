# Services

- `plugin.manager.search_api_autocomplete.suggester` — `Suggester\SuggesterManager`; discover/
  instantiate suggester plugins.
- `plugin.manager.search_api_autocomplete.search` — `Search\SearchPluginManager`; discover/
  instantiate search plugins.
- `search_api_autocomplete.plugin_helper` — `Utility\PluginHelper`; create configured suggester/
  search plugin instances for a `SearchInterface` entity.
- `search_api_autocomplete.helper` — `Utility\AutocompleteHelper`; also tagged as the
  `_search_api_autocomplete` access check used by the autocomplete route.
- `logger.channel.search_api_autocomplete` — logger channel.

Config entity: load searches via the `search_api_autocomplete_search` entity type
(`Entity\Search`, storage `SearchStorage`). The AJAX endpoint is route
`search_api_autocomplete.autocomplete` at `/search_api_autocomplete/{search}`.

```php
$search = \Drupal::entityTypeManager()
  ->getStorage('search_api_autocomplete_search')
  ->load('my_view');
$helper = \Drupal::service('search_api_autocomplete.plugin_helper');
$suggesters = $helper->createSuggesterPlugins($search, array_keys($search->getSuggesterIds()));
```
