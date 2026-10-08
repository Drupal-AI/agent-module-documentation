<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Read-only archive JSON API (`/api/1/archive/…`)

Defined in `dkan_dataset_archiver.routing.yml`, served by `Controller/ArchiveApiController`
(service `dkan_dataset_archiver.archive_api_controller`). All routes are **GET**, gated by permission
**`access dataset archive api`**, and return a JSON payload `{ "data": [...], "meta": {...} }`
(`CachedJsonResponseTrait`). Each route validates its slugs with regex `requirements`.

## Routes

- `dkan_dataset_archiver.aggregate_api` —
  `/api/1/archive/aggregate/{type}/{aggregate_of}/{filter}/{link_type}` → `aggregateArchives()`.
  `type ∈ {current, annual}`; `aggregate_of ∈ {theme, keyword, all, none}` (default `all`);
  `filter` default `all`; `link_type ∈ {absolute, relative}` (default `absolute`).
- `dkan_dataset_archiver.aggregate_topic_api` —
  `/api/1/archive/aggregate/{aggregate_of}/{filter}/{link_type}` → `aggregateTopicArchives()`.
  `aggregate_of ∈ {theme, keyword}`. Lists that type's aggregates plus its annuals.
- `dkan_dataset_archiver.individual_api` —
  `/api/1/archive/individual/{link_type}/{filter_by}/{filter}` → `individualArchives()`.
  `filter_by ∈ {theme, keyword, none}` (default `none`); `filter` default `all`.

`link_type=relative` yields relative resource URLs; anything else is treated as absolute.

## Access + scoping

- Route access = `access dataset archive api` only.
- Result scoping is enforced inside `getBaseDdaArchiveQuery()`: `status = 1`, `accessCheck(TRUE)`, and an
  `access_level IN (...)` filter chosen from the caller's permissions —
  `view dataset public archive` → public levels, `view dataset non-public archive` → private levels, both
  → union, neither → forced empty result (`id = 0`). So a user with API access but no archive-view
  permission gets an empty list. Which access levels count as "private" follows the `treat_as_private`
  setting via `Util::getAccessLevelsThatAreConsidered{Private,Public}()`.
- `canShowArchivesBasedOnSettings()` returns HTTP 404 with a message when the requested aggregation type is
  disabled in settings (e.g. asking for `theme` aggregates while `archive_by_theme` is off).

## Payload + caching

- Items are assembled by `assemblePayloadItem()`: `name`, `id`, `type`, aggregate term, `url` (local file
  URL, else the `remote_url`), `size`, `date` (`dataset_modified`), `access_level`; individual items also
  carry `keywords`, `themes`, and the list of `resource_files` URLs. `meta` has `total_items`,
  `current_page`, `page_size` (500), `total_pages`.
- Responses are cached for 86400s (one day) under a cache id from `Util::getAggregationTag()` that
  **includes a hash of the current user's roles**, so differently-permissioned users get separate cached
  variants. Cache tags `dda_archive:{id}` are attached per included archive.

Directory-listing helpers in the controller (`getStructuredContentOfDirectory()`, League Flysystem `Local`
adapter over the public files dir) exist but the active endpoints above query the `dda_archive` entity, not
the raw filesystem.
