<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Algolia Search (`search_api_algolia`) is a Search API **backend** that indexes Drupal content into the hosted Algolia search engine. It handles indexing only — the search UI is built on the front-end with Algolia's JavaScript API.

---

The module registers a Search API backend plugin `search_api_algolia` (label "Algolia"). You create a Search API **server** with that backend and supply your Algolia **Application ID** and **Write API Key** (backend config keys `application_id`, `api_key`, plus `disable_truncate`); it connects using the `algolia/algoliasearch-client-php` (^4.0) library. Each Search API **index** gets extra options via a form alter: `algolia_index_name` (the Algolia index), `algolia_index_apply_suffix` (append a language code like `_en`/`_fr` for multilingual sites), `algolia_index_batch_deletion`, `object_id_field` (a custom field to use as Algolia `objectID`; requires batch deletion), and `partially_update_objects`. A `algolia_item_splitter` Search API processor can split one item into several Algolia records to stay under Algolia's record-size limit. Module-wide behaviour lives in the `search_api_algolia.settings` config object: `debug` (verbose logging) and `wait_for_delete` (wait for delete operations to finish). Deletions are queued (`search_api_algolia_deleted_items` table) and flushed by the Drush command `search_api_algolia:delete` (alias `sapia-d`, option `--batch-size`). Three alter hooks are provided — `hook_search_api_algolia_search_client_config_alter`, `hook_search_api_algolia_objects_alter`, and `hook_search_api_algolia_sorts_alter`. Sorting uses Algolia replicas and autocomplete uses Query Suggestions, following naming conventions documented in INSTALL.md.

---

- Index Drupal nodes/entities into an Algolia index via Search API.
- Add an Algolia server to Search API by choosing the "Algolia" backend.
- Store your Algolia Application ID and Write API Key on the server config.
- Point a Search API index at a specific Algolia index name (`algolia_index_name`).
- Create per-language Algolia indexes with a language suffix (`_en`, `_fr`) for multilingual sites.
- Use a custom field as the Algolia `objectID` instead of the Search API default.
- Enable batched deletion of Algolia objects for large indexes.
- Partially update Algolia objects instead of replacing whole records.
- Split large items into multiple Algolia records with the `algolia_item_splitter` processor.
- Stay under Algolia's per-record size limit for big content.
- Bulk-delete queued Algolia objects with `drush sapia-d` (`search_api_algolia:delete`).
- Tune deletion batch size with `drush sapia-d --batch-size=100`.
- Turn on debug logging for indexing via `search_api_algolia.settings` `debug`.
- Make delete operations wait for completion with `wait_for_delete`.
- Customise the Algolia client config (timeouts, headers) via `hook_search_api_algolia_search_client_config_alter`.
- Add or modify fields on records before indexing with `hook_search_api_algolia_objects_alter`.
- Remove or adjust sorts handled by index rankings with `hook_search_api_algolia_sorts_alter`.
- Power exposed sorting through Algolia replicas following the `PREFIX_LANGCODE_field_direction` convention.
- Provide autocomplete via Algolia Query Suggestions (`INDEX_query`) with search_api_autocomplete.
- Automatically remove an entity's Algolia record when the entity is deleted (`hook_entity_delete`).
- Choose processors (e.g. Entity status) on the index to exclude unpublished content before indexing.
- Migrate a Drupal site's search to a hosted, typo-tolerant Algolia experience.
- Keep the front-end search implementation in Algolia's JS while Drupal owns indexing.
