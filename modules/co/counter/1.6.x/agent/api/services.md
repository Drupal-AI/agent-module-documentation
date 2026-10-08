# Services & report endpoints

## `counter.counter_utility` — `Drupal\counter\CounterUtility`

Ctor args: `@database`, `@request_stack`, `@current_user`, `@config.factory`. Read/query
helpers used by the blocks and dashboard (all use the parameterized DB API query builder):

| method | returns |
|--------|---------|
| `getVisitorData()` | total row count of `counter` (= total views) |
| `getUniqueVisitorData()` | count of distinct `ip` |
| `getUniqueVisitorTimeRangeData($date1=0, $date2=0)` | distinct `ip` within a `created` range |
| `getTimeRangeData($date1, $date2=0)` | row count with `created > $date1` (and `< $date2`) |
| `getCounterLastDate($operator='<>', $order='DESC')` | first/last `created` value |
| `getTotalUsers($operator='<>', $status=1)` | count from `users_field_data` (uid<>0, `access` vs 0, `status`) |
| `getTotalNodes($status=1)` | count from `node_field_data` (0 if `node` module absent) |
| `getTopNodes($limit=20)` | array of `{nid,type,views,title,url}` grouped by node, ordered by view count |
| `getTopUrls($limit=20)` | array of `{url,views}` grouped by URL, ordered by view count |
| `getBrowserInformation($request=NULL)` | `['browser_name','browser_version','platform']` from the User-Agent |
| `recordCounterData(Request $request)` | build + insert a row for the current request (used by the middleware) |
| `insertCounterData(array $data)` | parameterized insert into `counter` (sets `created = time()`, truncates `url` to 255) |

## `counter.statistics_service` — `Drupal\counter\Service\StatisticsService`

Ctor args: `@database`, `@request_stack`, `@module_handler`. Powers the chart page.

`getStats(string $range, bool $compare = FALSE, ?string $startParam = NULL, ?string $endParam
= NULL): array` — returns `labels`, `series_views`, `series_unique`, totals, and (when
`$compare`) previous-period series plus `percent_*` / `direction_*`. `$range` is one of
`today|yesterday|7days|30days|month|year|all|custom`; `computeRange()` maps it to a
start/end/bucket (`hour`/`day`/`month`). Custom `start`/`end` are parsed with
`is_numeric()` / `strtotime()` and only ever used inside parameterized `created` range
conditions.

## Admin report routes (all require `administer counter`)

- `counter.dashboard` → `CounterDashboard::page()` — themes `counter_dashboard`: site/unique
  totals, registered/unregistered/blocked users, published/unpublished nodes, rolling
  today/week/month/year view + unique counts, and `getTopNodes()` / `getTopUrls()` lists.
  Attaches library `counter/counter.dashboard`.
- `counter.statistics` → `CounterStatistics::statisticsPage()` — themes `counter_statistics`,
  attaches library `counter/statistics` (Chart.js), and sets
  `drupalSettings.counter.dataUrl = /admin/config/counter/statistics/data`.
- `counter.statistics.data` → `CounterStatistics::statisticsData(Request)` — reads
  `range`/`compare`/`start`/`end` query params, returns `JsonResponse(getStats(...))`. Also
  gated by `administer counter`.

> The `counter/statistics` and `counter/counter.dashboard` libraries load external assets
> from CDNs (Chart.js via jsDelivr; W3.CSS, Google Fonts, Font Awesome). These only affect
> the admin report pages.
