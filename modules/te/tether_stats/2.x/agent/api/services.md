# Services, manager, storage, analytics and charts (code API)

## Services (`tether_stats.services.yml`)

| Service id | Class | Notes |
|---|---|---|
| `tether_stats.manager` | `TetherStatsManager` | Central facade. Args: `@database`, `@logger.channel.tether_stats`, `@config.factory`, `@link_generator`, `@plugin.manager.tether_stats.chart_renderer`. |
| `plugin.manager.tether_stats.chart_renderer` | `TetherStatsChartRendererPluginManager` | Chart renderer plugin manager (see [plugins/chart-renderer.md](../plugins/chart-renderer.md)). |
| `logger.channel.tether_stats` | (logger channel) | `tether_stats` log channel. |
| `tether_stats.request_subscriber` | `TetherStatsRequestSubscriber` | Maps each request to an element (see [api/tracking.md](tracking.md)). |
| `tether_stats.request_to_element_subscriber` | `TetherStatsRequestToElementSubscriber` | Default `REQUEST_TO_ELEMENT` listener; binds node pages to entity identity sets. |

## `TetherStatsManager` (the facade)

Key methods: `isActive()`; `getStorage()` → `TetherStatsStorage`; `getAnalyticsStorage()` →
`TetherStatsAnalyticsStorage`; `getSettings()` (ImmutableConfig `tether_stats.settings`);
`getLogger()`; `getDatabaseConnection()`; `getElement()` / `hasElement()` / `setElement()` (the
element bound to the current request); `getChartRenderer()` (instantiates the `chart_plugin`, falling
back to `tether_stats_google_charts` if missing); `generateLink($text, Url, $identitySet)` (builds a
link with `tether_stats-track-link` class and `data-*` identity attributes for JS click/impression
tracking); `testValidityOfIdentitySet()` (validates + logs). If `database` config ≠ `default`, the
manager switches the connection so all stat storage uses the alternate DB.

## `TetherStatsStorage` (write/load elements)

`loadElement(int $elid)`, `loadElementFromIdentitySet($set)`, `createElementFromIdentitySet($set)`
(insert-or-refresh within a transaction, TTL-gated), `getDerivativeUsageCount($derivative)`,
`trackActivity(...)`, `trackImpression($elid, $alid, $time)`. `TetherStatsElement` is the value
object (`getId`, `getCount`, `getCreated/Changed/LastActivity`, `getIdentityParameter(s)`, plus
static `loadElement`/`createElementFromIdentitySet` helpers that delegate to the manager's storage).

## `TetherStatsAnalyticsStorage` (read/mine)

Read-side query helpers, all returning either a total (when `$step` is NULL) or a `[step => count]`
map (when `$step` is `hour`/`day`/`month`/`year`), via the private `executeDataQuery()`:

- `getTopElementsForActivity($type, $start, $finish, $limit)` → `[elid => count]`.
- `getAllActivityCount($type, $start, $finish, $step?)`,
  `getElementActivityCount($elid, $type, $start, $finish, $step?)`.
- `getElementImpressedOnElementCount`, `getElementImpressedOnNodeBundleCount`,
  `getElementImpressedOnBaseUrlCount`, `getElementImpressedAnywhereCount`,
  `getAllElementsImpressedOnElementCount`.
- `getHitActivityWithReferrerCount`, `getElementHitActivityWithReferrerCount`,
  `getHitActivityWithBrowserCount`, `getElementHitActivityWithBrowserCount` (referrer/browser matched
  with `escapeLike`d `LIKE`).

Counts are read primarily from `tether_stats_hour_count`; referrer/browser queries hit
`tether_stats_activity_log`.

## Charts and the AJAX iteration route

Overview pages (`TetherStatsOverviewController::overviewPage` / `elementOverviewPage`) build **chart
schema** objects (`TetherStatsComboChartSchema`, `TetherStatsPieChartSchema`,
`TetherStatsSteppedChartSchema`), wrap them in **chart** objects (`TetherStatsComboChart`,
`TetherStatsPieChart`) that pull data from the analytics storage, and render them with the active
chart renderer (`getChartRenderer()->buildChart($chart, [], $iterate)`). For iterable charts the
renderer stores the schema in `tempstore.private` under `chart_schema_<schema id>` and attaches
`drupalSettings.tetherStatsGoogleChart`.

- **`tether_stats.chart.data`** — `/tether-stats/chart-data` (permission
  `view tether stats chart data`). `TetherStatsChartController::iterate()` reads `chart_id`, `start`
  (numeric), `direction` (`next`|`prev`) from `$_GET`, fetches the caller's **own** chart schema from
  `tempstore.private`, advances the date window (`nextDateTime`/`previousDateTime`), rebuilds the
  chart, and returns `{status, data, previous, next, start}`. It never accepts a schema from the
  request — only the id of a schema the same user's page already stored.

- **`tether_stats.derivative.autocomplete`** — `/tether_stats/autocomplete` (permission
  `administer tether stats`). `TetherStatsAutocompleteController::derivativeAutocomplete()` returns up
  to 10 derivative-name suggestions (entity query `CONTAINS` on `name`) as JSON `{value,label}` pairs.

## Events

`TetherStatsEvents::REQUEST_TO_ELEMENT` (`'tether_stats.request_to_element'`) is dispatched by the
request subscriber with a `TetherStatsRequestToElementEvent` (carries route match + request URI).
A listener calls `setIdentitySet(TetherStatsIdentitySet)` to bind the request to a specific element
and stop propagation; otherwise the URL-only default is used.
