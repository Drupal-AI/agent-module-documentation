<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend and processor plugins

The module does **not** define its own plugin type/manager; it provides two Search API
plugins (backend + processor).

## Backend: `search_api_algolia`

- Class `SearchApiAlgoliaBackend` (`@SearchApiBackend id = search_api_algolia`,
  label "Algolia").
- `defaultConfiguration()`: `application_id`, `api_key`, `disable_truncate` (FALSE).
- Implements `indexItems()`, `deleteItems()`, `search()`, `listIndexes()` against the Algolia
  PHP client (built from `application_id` + `api_key`).
- Reads `search_api_algolia.settings` `debug` and `wait_for_delete` at runtime.
- Only supports **indexing**; querying/search UI is expected on the front-end via Algolia's
  JS API (the `search()` method mainly backs Views/autocomplete integration).

Injected services: `language_manager`, `config.factory`, `search_api_algolia.helper`,
`module_handler`, `logger.channel.search_api_algolia`,
`search_api_algolia.search_query_helper`.

## Processor: `algolia_item_splitter`

- Class `ItemSplitter` extends `FieldsProcessorPluginBase`
  (`@SearchApiProcessor id = algolia_item_splitter`, label "Algolia item splitter").
- Splits a single item into multiple Algolia records so a large item does not exceed
  Algolia's per-record size limit.
- Enable it on the index's **Processors** tab and configure which fields to split.

## Helper services

| Service | Role |
|---|---|
| `search_api_algolia.helper` (`SearchApiAlgoliaHelper`) | `buildAlgoliaSearchClient()`, `entityDelete()`, `scheduleForDeletion()`. |
| `search_api_algolia.search_query_helper` (`SearchQueryHelper`) | `formatFilterValue()` for query filters. |

`hook_entity_delete()` calls `search_api_algolia.helper->entityDelete()` so deleting a Drupal
entity removes/queues its Algolia record.
