<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Mirror (api_orchestrator_mirror) — agent index

Maps an API Orchestrator endpoint response to a filterable/sortable local listing. Depends on `api_orchestrator`. All routes require `administer api orchestrator`. Lifecycle: experimental.

## Provides
- Config entity `api_mirror` (`ApiMirror`, config_prefix `api_mirror`, schema `config/schema/api_orchestrator_mirror.schema.yml`): `endpoint_id`, `root_path`, `remote_id_path`, `items_per_page`, `auto_sync`, `sync_interval`, `last_sync`, `field_mappings[]` (source_path/field_name/field_type/label/sortable/visible/weight), `filter_mappings[]` (field_name/filter_type/label/placeholder/options). Forms `ApiMirrorForm`/`ApiMirrorDeleteForm`, list builder `ApiMirrorListBuilder`.
- Services: `api_orchestrator_mirror.json_path_resolver` (`JsonPathResolver` — `resolve()`, `resolveArray()`, `flatten()`; dot-notation with `[]` iteration and `[N]` index), `api_orchestrator_mirror.query` (`MirrorQueryService` — fetch via orchestrator, map fields, filter/sort/paginate in PHP), `api_orchestrator_mirror.sync` (`MirrorSyncService` — `fetchSample()`; sync/purge are live-mode no-ops).
- SDC components `mirror_listing`, `mirror_config`.
- DB table `api_orchestrator_mirror_data` (declared in `.install`; unused by the current live-fetch mode).

## Routes (`api_orchestrator_mirror.routing.yml`)
- Mirror CRUD under `/admin/config/services/api-orchestrator/mirror` (`entity.api_mirror.*`).
- `…/mirror/{api_mirror}/data` → `MirrorDisplayController::display` (themed listing, AJAX-loaded).
- `…/mirror/{api_mirror}/sync` → `MirrorSyncController::sync` (redirects to display).
- `…/mirror/api/sample?endpoint_id=…` → `MirrorApiController::fetchSample` (flattened sample for path discovery).
- `…/mirror/{api_mirror}/api/query` → `MirrorApiController::queryData` (JSON rows with filters/sort/pagination).

Data flow: `queryData`/`display` → `MirrorQueryService::query()` → `orchestrator.createRequest(endpoint_id)` → reload `ApiRequest` response → `JsonPathResolver::resolveArray(root_path)` → map field_mappings → filter/sort/paginate. The fetched endpoint is admin-configured (no request-supplied target URL).
