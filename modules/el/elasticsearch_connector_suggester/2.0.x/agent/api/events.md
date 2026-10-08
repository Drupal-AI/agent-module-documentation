<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event subscribers & alter events

Registered in `elasticsearch_connector_suggester.services.yml`. All share `SubscriberTrait`
(`src/EventSubscriber/SubscriberTrait.php`) helpers: `getFields($index)` (returns the `fields`
config of the `elastic_live_results` suggester on the index's autocomplete search),
`loadIndexFromIndexName($name)`, and `getIndexName($index)` (via the ES backend client
`getIndexId()`).

## 1. FieldMappingEventSubscriber — map field as `completion`

`src/EventSubscriber/FieldMappingEventSubscriber.php`, subscribes to
`Drupal\elasticsearch_connector\Event\FieldMappingEvent` (`onFieldMapping`). For the first
suggester field on the index it adds to the mapping param:
`fields.completion = { type: 'completion', analyzer: <suggester analyzer or 'keyword'>,
max_input_length: 1000 }`. The analyzer is read from the `elastic_live_results` suggester's
`analyzer` config (default fallback `keyword`). This is what makes the field an ES completion
sub-field the query rewrite targets.

## 2. QueryParamsEventSubscriber — rewrite query into a `suggest` request

`src/EventSubscriber/QueryParamsEventSubscriber.php`, subscribes to
`Drupal\elasticsearch_connector\Event\QueryParamsEvent` (`onElasticsearchBuildQuery`). Injects
`entity_type.manager`, `event_dispatcher`, `current_route_match`. Flow:

1. Route gate: only acts when the current route is `search_api_autocomplete.autocomplete` (the name
   is first passed through a dispatched **`RouteNameEvent`** so it can be overridden).
2. Loads the index from `params['index']`; requires configured suggester fields.
3. Reads the requested field from `params.body.query.query_string.fields[0]` and matches it against
   the suggester fields (`getAutocompleteField()` uses `strpos`); dispatches **`FieldNameEvent`**
   (name, autocomplete name, params) so the field name can be altered/cancelled.
4. Reads the keys from `params.body.query.query_string.query`, strips ` AND`/`~` with
   `preg_replace`, then dispatches **`KeysEvent`** and uses its (possibly altered) keys as the
   prefix.
5. Replaces `params['body']` entirely with:
   `suggest.autocomplete = { prefix: <keys>, completion: { field: '<field>.completion',
   skip_duplicates: TRUE, size: 10 } }`.

The prefix/keys are placed as **structured JSON param values** handed to the Elasticsearch client,
not concatenated into a query string.

## 3. ConfigEventsSubscriber — reindex on autocomplete config save

`src/EventSubscriber/ConfigEventsSubscriber.php`, subscribes to `ConfigEvents::SAVE`
(`onConfigSave`). When the saved config name matches `^search_api_autocomplete.search.*$`, it loads
the referenced `search_api_index` (by `index_id`) and calls `$index->save()`, forcing the ES mapping
(including the new `completion` field) to be rebuilt.

## 4. SearchApiProcessingResultsSubscriber — inject suggest options as items

`src/EventSubscriber/SearchApiProcessingResultsSubscriber.php`, subscribes to
`SearchApiEvents::PROCESSING_RESULTS` (`onSearchApiProcessingResults`), with
`@search_api.fields_helper`. Only when the result set is empty: reads
`elasticsearch_response.suggest.autocomplete[0].options` and, for each option, creates a Search API
item (`fieldsHelper->createItem($index, $item['_id'])`, score set) and adds it to the result set.
The suggester (see `plugins/suggester.md`) then re-checks access and URL before rendering.

## Alter events (`src/Event/`)

- **`RouteNameEvent`** — `get/setName()`; change which route counts as the autocomplete route.
- **`FieldNameEvent`** — `getName()`, `getAutocompleteName()`, `getParams()`
  (note: setter is misspelled `setAutocompleteNmae()`); alter/cancel the matched field.
- **`KeysEvent`** — `get/setKeys()`, `getParams()`; alter the prefix sent to Elasticsearch.
