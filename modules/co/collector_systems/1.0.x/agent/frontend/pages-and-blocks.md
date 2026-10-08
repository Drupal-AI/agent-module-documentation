<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end: pages, blocks, AJAX & advanced search

Everything the public sees is rendered from the **local mirror tables**, never live from the API.

## Detail-page routes — `PageTemplatesController`

Five routes, all `_permission: access content` (i.e. viewable by anonymous by design — the module's
purpose is to publish a collection):

| Route | Path | Method | Theme hook |
|---|---|---|---|
| `collector_systems.object_detail_page` | `/artobject-detail` | `ObjectDetailPage` | `artobject-detail-page` |
| `collector_systems.artist_detail_page` | `/artist-detail` | `ArtistDetailPage` | `artist-detail-page` |
| `collector_systems.exhibition_detail_page` | `/exhibition-detail` | `ExhibitionDetailPage` | `exhibition-detail-page` |
| `collector_systems.groups_detail_page` | `/group-detail` | `GroupDetailPage` | `group-detail-page` |
| `collector_systems.collection_detail_page` | `/collection-detail` | `CollectionDetailPage` | `collection-detail-page` |

Each reads `dataId`/`pageNo`/`sortBy`/`qSearch` from the request, queries the local tables (via the
Drupal DB API, cast/escaped), and builds a themed render array. When `enable_maps` is on and the
object has Latitude/Longitude, it injects `drupalSettings.azure_map` including the Azure Maps
`subscription_key` (a client-side map key) and location pins.

## List blocks

Five block plugins under `Plugin/Block/` (admin labels): `collector_systems_objects` (Objects),
`collector_systems_artists` (Artists), `collector_systems_collections`, `collector_systems_exhibitions`,
`collector_systems_groups`. Each queries the mirror tables through `ObjectsService` /
`AdvancedSearchService`, paginates by `items_per_page`, and renders the matching list template.
`CollectorSystemsArtists` also pushes an A–Z index to `drupalSettings.collectorSystems.artistsAlpha`.

## AJAX endpoints — `AjaxRequestsController`

- `custom_api_integration.group_level_objects_searching_page` → `/v1/group-level-objects-searching-page`,
  `access content`. Server-renders the nested object list for an artist/exhibition/group/collection
  detail page (POST `pagename`, `groupTypeId`, paging, `searchWord`, `groupLevelOrderBy`). Returns a
  JSON `{groupLevelSearchHtml}` fragment built with the `getObjectslistHtml` Twig function.
- `collector_systems.artists_load_more` → `/collector-systems/artists/load-more` (`access content`,
  `no_cache`). Infinite-scroll artist cards; builds HTML with `htmlspecialchars()` on every value.
- `collector_systems.get_images_count_data`, `.get_total_count_data`,
  `.save_checkbox_options_data_type` — all `administer site configuration`; dashboard AJAX
  (API-vs-DB counts, and saving which entity types to include in image sync). `saveCheckBoxOptionsDataType`
  reads `$_POST['checkboxes']` and writes them into `collector_systems.settings`.

### Query-safety notes (checked)

The search/list queries take request input but are built defensively: the "order by" value is
validated against a fixed allow-list (`AjaxRequestsController::ALLOWED_ORDER_BY`) before use; search
terms go through `Connection::escapeLike()` and are bound as `LIKE` parameters; the set of columns a
search term may hit is intersected with the **actual** table columns
(`ObjectsService::cs_get_table_columns()` via `SHOW COLUMNS`), so a request cannot inject an
arbitrary column/identifier; IDs are cast to `int`. `cs_get_table_columns()` interpolates only
hardcoded internal table names into its `SHOW COLUMNS` string, not request data.

## Advanced search — `AdvancedSearchService`

Service `collector_systems.advanced_search_service`, **off unless** `enable_advanced_search` is set.
`getFields($pagename)` returns per-page field definitions (Objects fields are dynamic from the field
registry; Artists/Groups/Exhibitions are hardcoded lists mirroring the plain search; Exhibitions
adds a date-range field). A request is "advanced" when `$_REQUEST['advSearch']` is set;
`buildConditionGroup()` reads the `adv_*` params, `escapeLike()`s text values into `LIKE` conditions
and builds interval-overlap conditions for date ranges — resolving each field to a column only on
tables the caller's query actually joins (so it can't reference a missing alias). Advanced search and
the plain search box are mutually exclusive (advanced wins).

## Rendering / Twig — `CustomTwig`

Twig extension (service `collector_systems.twig.CustomTwig`) providing `getObjectslistHtml`,
`GetCustomizedObjectDetailsForTheme`, `customPaginationForTopLevelTabs`,
`customPaginationForGroupLevelObjects`, `base64_encode`. These functions are declared
`is_safe: html`, so they are responsible for their own escaping — and they are: field values come
from `Csfieldresolver::getValue()` which applies `Html::escape()` (generic) / `Xss::filterAdmin()`
(rich text), URLs/labels are passed through `Html::escape()`, and record IDs are cast to `int`
before being embedded in links/`onclick` handlers. Image blobs are emitted as
`data:image/jpeg;base64,…`. The net effect is that synced Collector Systems data (titles, artist
bios, memos, etc.) is sanitized before it reaches the page.
