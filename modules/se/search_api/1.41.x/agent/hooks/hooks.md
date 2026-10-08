# Hooks

Documented in `search_api.api.php`. Implement in a `.module` file or an OOP `#[Hook]` class
(see `src/Hook/`).

## Alter discovered plugin definitions
- `hook_search_api_backend_info_alter(&$definitions)`
- `hook_search_api_datasource_info_alter(&$infos)`
- `hook_search_api_processor_info_alter(&$definitions)`
- `hook_search_api_data_type_info_alter(&$definitions)`
- `hook_search_api_parse_mode_info_alter(&$definitions)`
- `hook_search_api_tracker_info_alter(&$definitions)`
- `hook_search_api_displays_alter(&$displays)`
- `hook_search_api_server_features_alter(ServerInterface $server, array &$features)`

## Indexing
- `hook_search_api_index_items_alter(IndexInterface $index, array &$items)` — change items before indexing.
- `hook_search_api_items_indexed(IndexInterface $index, array $item_ids)` — react after items indexed.
- `hook_search_api_index_reindex(IndexInterface $index, $clear)` — react when an index is scheduled for re-indexing.

## Querying
- `hook_search_api_query_alter(QueryInterface $query)` — alter every query.
- `hook_search_api_query_TAG_alter(QueryInterface $query)` — alter only queries carrying a tag (see `addTag()`).
- `hook_search_api_results_alter(ResultSetInterface $results)` — alter results after execution.
- `hook_search_api_results_TAG_alter(ResultSetInterface $results)` — tagged-results variant.

## Views field-type mapping
- `hook_search_api_field_type_mapping_alter(&$mapping)`
- `hook_search_api_views_handler_mapping_alter(&$mapping)`
- `hook_search_api_views_field_handler_mapping_alter(&$mapping)`
