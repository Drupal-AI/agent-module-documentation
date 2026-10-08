<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Management routes, tabs & permissions

Defined in `search_api_typesense.routing.yml`, `search_api_typesense.links.task.yml`,
`search_api_typesense.permissions.yml`, `search_api_typesense.services.yml`.

## Permissions

- `administer search_api_typesense synonyms`
- `administer search_api_typesense stopwords`
- `administer search_api_typesense curations`

Most routes require `administer search_api`; synonyms/curations/stopwords routes require
`administer search_api+administer search_api_typesense <x>` (either permission grants access, per
Drupal's `+` semantics). The `typesense_schema` entity's `admin_permission` is `administer search_api`.

## Access checks

Two custom access services gate the tabs so they appear only for Typesense-backed servers/indexes:

- `_search_api_typesense_server_local_action_access_check` →
  `Access\ServerLocalActionAccessCheck` (arg `@current_user`).
- `_search_api_typesense_index_local_action_access_check` →
  `Access\IndexLocalActionAccessCheck` — allows only when the index's server backend is a
  `SearchApiTypesenseBackend`, else forbidden.

## Server tabs (`base_route: entity.search_api_server.canonical`)

`/admin/config/search/search-api/server/{search_api_server}/…`

| Path suffix | Route | Handler | Notes |
|---|---|---|---|
| `metrics` | `…server.metrics` | `Controller\TypesenseServerController::metrics` | live metrics |
| `api-keys` | `…server.api_keys` | `Form\ApiKeysForm` | create/list keys |
| `api-keys/{id}/delete` | `…server.api_keys.delete` | `Form\ApiKeyDeleteForm` | |
| `scoped-api-keys` | `…server.scoped_api_keys` | `Form\ScopedApiKeysForm` | scoped search key |
| `stopwords` | `…server.stopwords` | `Form\StopwordsForm` | +stopwords perm |
| `stopwords/{id}/delete` | `…server.stopwords.delete` | `Form\StopwordDeleteForm` | |
| `conversations` | `…server.conversations` | `Form\ConversationsForm` | conversation models |
| `conversations/{id}/delete` | `…server.conversations.delete` | `Form\ConversationDeleteForm` | |

## Index tabs (`base_route: entity.search_api_index.canonical`)

`/admin/config/search/search-api/index/{search_api_index}/…`

| Path suffix | Route | Handler | Notes |
|---|---|---|---|
| `schema` | `…collection.schema` | `_entity_form: typesense_schema` (`Form\SchemaForm`) | required before indexing |
| `synonyms` | `…collection.synonyms` | `Form\SynonymsForm` | +synonyms perm |
| `synonyms/{id}/delete` | `…collection.synonyms.delete` | `Form\SynonymDeleteForm` | |
| `curations` | `…collection.curations` | `Form\CurationsForm` | +curations perm |
| `curations/{id}/delete` | `…collection.curations.delete` | `Form\CurationDeleteForm` | |
| `import` | `…collection.import` | `Form\CollectionImportForm` | JSON import |
| `export` | `…collection.export` | `Form\CollectionExportForm` | |
| `export_download` | `…collection.export_download` | `controller.collection_export` (`Controller\CollectionExportController`) | file download |
| `search` | `…collection.search` | `Controller\TypesenseIndexController::search` | InstantSearch preview |
| `converse` | `…collection.converse` | `Controller\TypesenseIndexController::converse` | conversational search |

## Document splitter entity routes

`/admin/structure/document-splitter[/add|/{document_splitter}|/{…}/delete]` — `document_splitter`
config entity forms, permission `administer document_splitter`.

## Config objects

- `search_api_typesense.settings` — `ts_embedding_models` (Typesense built-in `ts/…` embedding
  models; seeded in `config/install`, updated by `search_api_typesense_update_8001()`).
- `search_api_typesense.search_keys` — `servers.<id>.search_only_key` (per-server search-only key,
  written by `Form\SearchOnlyKeyConfigForm`, read by the search controller/block).
- `block.settings.search_api_typesense_search_block` — server, collections, hits_per_page,
  search_only_key.

## Hooks

`Hook\SearchApiTypesenseHooks` (service, dispatched from `.module` via `#[LegacyHook]`): `help()`,
`theme()` (templates in `templates/`), `formAlter()`.
