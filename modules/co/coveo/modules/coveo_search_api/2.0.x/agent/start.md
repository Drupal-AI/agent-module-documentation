<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo Search API (coveo_search_api) — agent index

Submodule of **Coveo** that connects Drupal **Search API** to Coveo: a backend that pushes content to a
Coveo Push source, plus data-type/processor/field plugins. Depends on `coveo` **and `search_api`**
(`coveo_search_api.info.yml`). Package Search. Core `^10 || ^11`. No permissions, no config schema.

- **Backend, plugins, sync, events** → [search-api/backend-and-plugins.md](search-api/backend-and-plugins.md)

## What it provides

- **Search API backend** `coveo` — `src/Plugin/search_api/backend/SearchApiCoveoBackend.php`
  (`@SearchApiBackend id="coveo"`). Serializes items to Coveo `DocumentBody` batches and pushes via the
  base module's `Coveo\Index` (push key from the org); can query via `SearchV2Api`.
- **Data type** `coveo_file` — `src/Plugin/search_api/data_type/FileDataType.php`.
- **Processors** — `coveo_file_attachments` (`CoveoFileExtractor`, adds file-attachment content) and
  `coveo_hierarchy` (`CoveoDynamicHierarchy`, extends core `AddHierarchy` → Coveo
  DynamicHierarchicalFacet format).
- **Field type** `FileUriItemAbsolute` (extends core `FileUriItem`) + `ComputedFileUriAbsolute` — an
  absolute file URI property for indexing.
- **Sync** — `SyncFields` (`coveo_search_api.sync`) keeps Coveo field defs aligned; `CoveoServers`
  (`coveo_search_api.server_storage`) resolves Coveo Search API servers.
- **Subscribers** — `CoveoSubscriber`, `SearchApiSubscriber` (event subscribers); hooks in
  `src/Hook/CoveoSearchApiHooks.php` and `src/Hook/SearchApiIndexHooks.php` (autowired).

## Events (`src/Event/`) and legacy hook

- `CoveoDocumentAlter`, `CoveoDocumentsAlter`, `CoveoFieldDataAlter`, `CoveoFieldOperationsAlter`.
- `coveo_search_api.api.php` documents `hook_coveo_objects_alter(&$objects, $index, $items)` to modify
  documents before indexing.

## Setup

Enable `coveo_search_api`, add a Search API server of type **Coveo** with the query/search key, create
indexes and name fields `coveo_data`, `coveo_title`, and other `coveo_*` fields (see the base module's
README). Then index as usual — items are pushed to the configured Coveo organization/source.
