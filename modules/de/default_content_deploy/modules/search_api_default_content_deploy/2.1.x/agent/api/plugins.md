# Search API plugins & services

This submodule does **not** define new plugin types; it supplies plugins for
Search API's existing types plus supporting services.

## Backend plugin — `search_api_default_content_deploy`

`Drupal\search_api_default_content_deploy\Plugin\search_api\backend\DefaultContentDeployBackend`
(`@SearchApiBackend`). A write-only backend: instead of indexing to a search engine it
exports tracked items to JSON files through `default_content_deploy.exporter`.

- `indexItems($index, $items)` — per `dcd_entity` item, sets exporter options from the
  index's third-party settings and calls `exportEntity($entity, $export_referenced_entities)`.
- `deleteItems($index, $ids)` — when `delete_single_file_allowed`, deletes (or, with
  `move_deleted_single_file`, moves to `_deleted/` and stamps `delete_timestamp`) the file.
- `deleteAllIndexItems($index, $datasource_id = NULL)` — when `delete_all_files_allowed`,
  recursively deletes the export folder or a per-entity-type subfolder.
- `search()` is empty; `getDiscouragedProcessors()` lists search processors that make no
  sense for a file export.

## Datasource plugin — `dcd_entity`

`Plugin/search_api/datasource/DefaultContentDeployContentEntity` with
`DefaultContentDeployContentEntityDeriver` (one derivative per content entity type,
e.g. `dcd_entity:node`). Its config schema reuses core's entity-datasource schema
(`plugin.plugin_configuration.search_api_datasource.dcd_entity:*`). Change tracking is
handled by `DefaultContentDeployContentEntityTrackingManager` (service
`search_api_default_content_deploy.dcd_entity_datasource.tracking_manager`, args:
`entity_type.manager`, `language_manager`, `search_api.task_manager`), driven by the
module's `hook_entity_insert/update/delete` and `hook_search_api_index_update`.

## Event subscriber

`search_api_default_content_deploy.default_content_deploy_event_subscriber`
(`EventSubscriber\DefaultContentDeployEventSubscriber`) subscribes to Search API's
`INDEXING_ITEMS` (to record which index is exporting) and to the parent's
`PRE_SERIALIZE` / `POST_SERIALIZE` events (to stamp the index id, rewrite the HAL link
domain, and skip writing files whose only difference is the export timestamp). See the
parent's [events doc](../../../../../2.1.x/agent/events/events.md).

## Helper functions (procedural)

- `search_api_default_content_deploy_get_servers($only_active = TRUE)` — Search API
  servers using the DCD backend.
- `search_api_default_content_deploy_default_index_third_party_settings()` /
  `…_merge_default_index_third_party_settings($settings)` — default + merged per-index settings.
