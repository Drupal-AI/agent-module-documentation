# Piwik Pro Dashboard — routes, API client, auth flow

## Routes (`piwik_pro_dashboard.routing.yml`)

All under permission `access piwik pro dashboard`:

| Route | Path | Returns |
|---|---|---|
| `piwik_pro_dashboard.dashboard_page` | `/admin/reports/piwik-dashboard` | HTML page (`DashboardController::render`) loading the React app library `piwik_pro_dashboard/dashboard_app` |
| `piwik_pro_dashboard.api.overview` | `/api/piwik-dashboard/overview` | JSON overview (`ApiController::getOverview`) |
| `piwik_pro_dashboard.api_devices` | `/api/piwik-dashboard/devices` | JSON device breakdown (`getDevices`) |
| `piwik_pro_dashboard.api_top_pages` | `/api/piwik-dashboard/top-pages` | JSON top pages (`getTopPages`) |
| `piwik_pro_dashboard.settings` | `/admin/config/services/piwik-pro/dashboard` | settings form (perm `administer piwik pro dashboard`) |

The JSON endpoints accept query args: `range` (validated against the `DateRange` enum — last 7 /
last 30 days; falls back to Last7Days) and, for overview, `aggregated=true`. On any exception
they log to channel `piwik_pro_dashboard` and return `{"error": "..."}` with HTTP 500.

## Services

- **`piwik_pro_dashboard.api_client`** (`Service\PiwikApiClient`) — injects `http_client`, the
  access-token manager, `config.factory`, `client_name_helper`, `logger.factory`. Methods:
  `fetchOverviewData($aggregated, $range)`, `fetchDeviceData($range)`, and the top-pages fetch;
  each calls the Piwik PRO Analytics API with a bearer token.
- **`piwik_pro_dashboard.access_token_manager`** (`Service\AccessTokenManager`) —
  `getAccessToken()`: returns a cached token from `piwik_pro_dashboard.access_token` if present;
  otherwise reads `client_id` and the Key ID (`client_secret`) from config, loads the Key entity
  and calls `getKeyValue()` for the real secret, POSTs
  `{grant_type: client_credentials, client_id, client_secret}` to
  `https://<client>.piwik.pro/auth/token`, then caches `access_token` in the **default cache
  bin** until `time() + expires_in - 60`. Errors are logged and rethrown as `RuntimeException`.
- **`piwik_pro_dashboard.client_name_helper`** (`Helper\ClientNameHelper`) — derives `<client>`
  (the Piwik PRO subdomain) from the base module's `piwik_domain`.

## Front-end

React app in `js/assets/` (built from `react-app/`), attached via library
`piwik_pro_dashboard/dashboard_app`. It calls the three JSON routes above and renders overview
tiles, line/pie charts, a top-pages list, and a 7/30-day range selector.
