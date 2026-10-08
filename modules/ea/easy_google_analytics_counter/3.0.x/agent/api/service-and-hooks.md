<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, GA report flow, hooks & the page_views field

## Service `easy_google_analytics_counter.connection`

`Drupal\easy_google_analytics_counter\ConnectionService` (implements `ConnectionServiceInterface`),
constructed with the whole `@service_container` (services are lazily fetched via
`config()`, `logger()`, `moduleHandler()`). Public API:

- `request(string $page_path = '')` — run the GA report and store counts. Optional `$page_path`
  restricts the report to one page path (via a GA `FilterExpression`, stored under `metricFilter`).
- `config(): ImmutableConfig` — the `easy_google_analytics_counter.admin` config.
- `logger(): LoggerChannelFactoryInterface`, `moduleHandler(): ModuleHandlerInterface`.

## Fetch flow (`ConnectionService::request()`)

1. `setKeyLocation()` (lines 258-274): resolves the credential file — `service_account_credentials_json_path`
   if set, otherwise loads the uploaded `service_account_credentials_json` file entity and takes its
   realpath — then `putenv('GOOGLE_APPLICATION_CREDENTIALS=' . $url)`.
2. `new BetaAnalyticsDataClient()` (no args) → picks up Application Default Credentials from that env var.
3. Builds the report `$query`: `property => 'properties/' . view_id`; `DateRange` `"{start_date}daysAgo"`
   → `today`; dimensions `pagePath` (+ `sort_dimension` unless `screenpageviews`); metric
   `screenPageViews`; `OrderBy` `screenPageViews` desc; `Limit => number_items`.
4. `moduleHandler()->alter('easy_google_analytics_counter_query', $query)` — modules may alter it.
5. `$google_client->runReport($query)` → `setData($response)`. Errors are caught and logged to the
   `easy_google_analytics_counter` channel (no exception propagates).

## `setData()` → `updateNodePageViews()`

- Iterates response rows; for each `pagePath` dimension resolves the alias to a system path with
  `path_alias.manager` (`getPathByAlias`, stripping any `?query`), matches `#node/(\d+)$#`, and sums
  page views per node id (`$ga_views[nid]`).
- `debug` on → writes `[page_views, GA path, system path]` rows to `public://ga_alias_file.csv`.
- `updateNodePageViews()`: for each nid, `UPDATE node_field_data SET page_views = :v WHERE nid = :nid
  AND (page_views <> :v OR page_views IS NULL)` (Database API update, parameterised — no raw SQL).
  On any change it invalidates cache tag `easy_google_analytics_counter_page_views` and invokes
  `hook_easy_google_analytics_counter_update_node_page_views($update_nids)`.

## Hooks (`.api.php`)

- `hook_easy_google_analytics_counter_query_alter(array $query)` — alter the GA report query before
  `runReport` (e.g. add dimensions). Invoked via `moduleHandler()->alter()`.
- `hook_easy_google_analytics_counter_update_node_page_views(array $update_nids)` — `$update_nids` is
  page-views keyed by node id; runs after counts are written. Invoked via `invokeAll()`.

## The `page_views` base field

Defined in `easy_google_analytics_counter_entity_base_field_info()` (`.module`): a
`BaseFieldDefinition::create('integer')` labelled *"Page views"* attached to the `node` entity type
only, materialising the `page_views` column on `node_field_data`. It is a plain storage field
(no widget/formatter/form-display config) that Views exposes as field/filter/sort.
