<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# coveo Search API backend & plugins

Enable: `drush en coveo_search_api` (requires `coveo` + `search_api`). Then add a Search API server of
type **Coveo** at `/admin/config/search/search-api/add-server` and point indexes at it.

## Backend `coveo` (`SearchApiCoveoBackend`)

`src/Plugin/search_api/backend/SearchApiCoveoBackend.php`, `@SearchApiBackend id="coveo"`. Injected
services include the logger, entity type manager, event dispatcher, time, module handler,
`SearchApiFactory`, `SyncFields`, `FieldConverter`. Responsibilities:

- **Index/push**: builds `NecLimDul\Coveo\PushApi\Model\DocumentBody` objects from Search API
  `ItemInterface`s (via `DocumentBody`/`BatchDocumentBody`), dispatches `CoveoDocumentAlter` per item and
  `CoveoDocumentsAlter` for the batch (and the legacy `hook_coveo_objects_alter`), then pushes through
  the organization's `Coveo\Index` helper (`ItemApi`/`FileContainerApi`, authenticated with the org
  push key). Deletions go through the item/delete APIs.
- **Query**: uses `SearchV2Api` (via `coveo.rest.search_api_factory`, search key) to run
  `RestQueryParameters` and map `RestQueryResponse` back to Search API results.
- Field mapping uses `FieldConverter` (organization `prefix`) — index fields named `coveo_data`,
  `coveo_title`, and other `coveo_*` map to Coveo internal fields.
- Errors are logged via `ApiError::logError` / `DrupalError::logException` on the Coveo log channel; the
  Guzzle client uses default TLS verification.

## Data type, processors, field

- **`coveo_file`** data type — `src/Plugin/search_api/data_type/FileDataType.php` (`@SearchApiDataType`).
- **`coveo_file_attachments`** processor — `CoveoFileExtractor` (`add_properties` stage) pulls file
  field contents into the indexed data (open TODOs: no file-type/size/cardinality limits yet).
- **`coveo_hierarchy`** processor — `CoveoDynamicHierarchy` extends core `AddHierarchy`
  (`preprocess_index` −45) and rewrites parent ids into `|`/`;`-joined names for Coveo hierarchical
  facets.
- **`FileUriItemAbsolute`** — `src/Plugin/Field/FieldType/FileUriItemAbsolute.php` extends core
  `FileUriItem`; backed by `ComputedFileUriAbsolute` to expose an absolute file URI for indexing.

## Sync & subscribers (`coveo_search_api.services.yml`)

- `coveo_search_api.sync` (`SyncFields`) — reconciles Coveo field definitions with Search API fields.
- `coveo_search_api.server_storage` (`CoveoServers`) — locates Coveo-backed Search API servers.
- `coveo_search_api.coveo_subscriber` (`CoveoSubscriber`) and `coveo_search_api.search_api_subscriber`
  (`SearchApiSubscriber`) — event subscribers reacting to Coveo/Search API events.
- Hook classes `CoveoSearchApiHooks` and `SearchApiIndexHooks` (autowired).

## Extending

Subscribe to `CoveoDocumentAlter` / `CoveoDocumentsAlter` (adjust documents), `CoveoFieldDataAlter` /
`CoveoFieldOperationsAlter` (adjust field payloads/operations), or implement
`hook_coveo_objects_alter(&$objects, $index, $items)` to set additional Coveo document properties.
