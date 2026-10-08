# Signals API and the click endpoint

Fusion learns ranking from **signals**. This module emits two signal types (`request` and `click`) and
exposes one route for click signals.

## Route: click signal

| | |
|---|---|
| Route name | `search_api_fusion.signal.click` |
| Path | `search_api_fusion/signals/click/{search_api_server}` |
| Controller | `Controller\FusionSignalController::send()` |
| Requirement | `_permission: 'send signals to any fusion server'` |
| Param | `{search_api_server}` upcast to a `ServerInterface` (`options.parameters … with_config_overrides: TRUE`) |
| Response | `204 No Content`, no-cache headers |

`send()` reads `request->query->all()`, forces `app_id` = the server's original id, and **allowlists** the
parameters with `array_intersect_key` against: `fusion_query_id, session, query, ctype, ip_address, doc_id,
doc_ids_s, url, app_id, res_pos, filter, filter_field`. It then calls `$connector->sendSignal('click', $params)`
and returns 204. The controller renders **no** server content back to the caller.

You rarely build this URL by hand — the event subscriber (below) generates it as a `ping` query on each
result link, so the browser fires it when the user clicks a result.

## Connector methods (public API on FusionConnector)

| Method | Behavior |
|---|---|
| `sendSignal(string $type, array $params, int $timeout = 5): void` | POSTs `[{timestamp, type, params}]` (params gain `ip_address` and `referrer`) as JSON to `/api/signals/<app>`, using the connector's basic-auth credentials and a **5-second** timeout (kept low so a slow Fusion does not slow the user). Expects HTTP **204**; on another code it logs and throws `SearchApiException`; Guzzle exceptions are logged and not rethrown. |
| `queryProfile(QueryInterface $query, string $query_profile)` | Sends a query to `/api/apps/<app>/query/<profile>`. Used by `search()` and by the autocomplete suggester. |
| `getSignalParamsFilter(SearchApiQueryInterface $query): array` | Builds `filter` / `filter_field` arrays from the query's active `=` conditions (plus the facet "missing" case), formatted `field/value` as Fusion's signals API expects; complex groups and other operators are ignored. |

## Event subscriber

`EventSubscriber\SearchApiFusionSubscriber` (service `search_api_fusion.search_api_fusion_subscriber`, logger
channel `logger.channel.search_api_fusion`) listens on `SearchApiSolrEvents::POST_EXTRACT_RESULTS`. When the
server's connector is `fusion` **and** `fusion_click_signals` is enabled, `addClickSignalUrl()`:

- reads the `x-fusion-query-id` response header,
- attaches a `ping` extra-data `Url` (the click route above, carrying `query`, `res_pos`, `doc_id`,
  `fusion_query_id`, facet filters, etc.) to each result item, and
- builds `ping` URLs for any Fusion **landing pages** (`fusion.landing-pages`, formatted `url$$$title`) in the
  response.

`Plugin\views\field\SearchApiFusionStandard::getItemUrl()` then copies that `ping` onto the rendered link's
HTML attributes so the browser sends the click signal on navigation.
