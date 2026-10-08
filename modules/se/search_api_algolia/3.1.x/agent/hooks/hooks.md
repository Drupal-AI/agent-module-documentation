<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (from `search_api_algolia.api.php`)

Three alter hooks let other modules customise the Algolia client and the records/sorts.

## `hook_search_api_algolia_search_client_config_alter(SearchConfig $config)`

Customise the Algolia search client configuration / API requests (timeouts, headers).

```php
function mymodule_search_api_algolia_search_client_config_alter(\Algolia\AlgoliaSearch\Configuration\SearchConfig $config) {
  $config->setConnectTimeout(10);
  $config->setDefaultHeaders(['name' => 'value']);
}
```

## `hook_search_api_algolia_objects_alter(array &$objects, IndexInterface $index, array $items)`

Alter the Algolia objects (records) before they are sent for indexing — add/remove fields,
reshape records. `$objects` are the records generated from `$items`.

```php
function mymodule_search_api_algolia_objects_alter(array &$objects, \Drupal\search_api\IndexInterface $index, array $items) {
  foreach ($objects as $key => $object) {
    $objects[$key]['foo'] = 'bar';
  }
}
```

## `hook_search_api_algolia_sorts_alter(array &$sorts, IndexInterface $index)`

Remove or adjust sorts that are handled via Algolia index rankings/replicas.

```php
function mymodule_search_api_algolia_sorts_alter(array &$sorts, \Drupal\search_api\IndexInterface $index) {
  unset($sorts['stock']);
}
```

There is no `.module`-level API beyond these hooks plus the two helper services
(`search_api_algolia.helper`, `search_api_algolia.search_query_helper`).
