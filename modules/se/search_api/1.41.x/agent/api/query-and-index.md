# Query & index in code

## Build and run a search
Get the index config entity, then its `QueryInterface` (`src/Query/QueryInterface.php`).
```php
/** @var \Drupal\search_api\IndexInterface $index */
$index = \Drupal::entityTypeManager()
  ->getStorage('search_api_index')->load('default_index');

$query = $index->query();                       // or: search_api.query_helper createQuery($index)
$query->keys('hello world');                    // full-text keywords
$query->setFulltextFields(['title', 'body']);
$query->addCondition('status', 1);              // ConditionSetInterface
$group = $query->createConditionGroup('OR');
$group->addCondition('type', 'article')->addCondition('type', 'page');
$query->addConditionGroup($group);
$query->sort('created', 'DESC');
$query->range(0, 10);                           // offset, limit
$query->addTag('my_search');                    // for hook_search_api_query_TAG_alter()

$results = $query->execute();                    // ResultSetInterface
foreach ($results->getResultItems() as $item) {
  $entity = $item->getOriginalObject()->getValue();
}
$total = $results->getResultCount();
```
- `search_api.query_helper` (`QueryHelperInterface`) creates queries and can store/retrieve
  the results for a search id (used by Facets, Views).
- Parse the keyword string differently with `setParseMode()` (a `search_api_parse_mode` plugin).

## Index / clear in code
`IndexInterface` (`src/IndexInterface.php`):
```php
$index->indexItems();          // index a batch of tracked items (respects cron_limit)
$index->reindex();             // mark all items for re-indexing
$index->clear();               // wipe indexed data on the server
$item = $index->loadItem('entity:node/123:en');
```
Trackers expose what still needs indexing; batch/cron/Drush drive `indexItems()`.
`search_api.post_request_indexing` indexes changed items at the end of the request.

## Useful services (`search_api.services.yml`)
- `search_api.fields_helper` — build/inspect index fields & items.
- `search_api.query_helper` — create queries, cache result sets.
- `search_api.plugin_helper` — instantiate datasource/processor/tracker plugins.
- `search_api.data_type_helper`, `search_api.tracking_helper`, `search_api.index_task_manager`.
