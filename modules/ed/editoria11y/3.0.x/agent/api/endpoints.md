# Dashboard & JSON API

## Dashboard
`DashboardController::dashboard` at `/admin/reports/editoria11y` (route
`editoria11y.reports_dashboard`, permission `manage editoria11y results`). Built on the bundled
Views `ed11y_result` and `ed11y_action` (`config/optional/`), with custom Views field plugins
(`PageLink`, `IssuesByPageLink`, `PagesByIssueLink`, `DismissalsByIssueLink`) that rebuild the
page/issue rollups. Data is served by the `editoria11y.dashboard` service (`Dashboard.php`).

## JSON endpoints (front-end checker → Drupal)
All POST, require login, JSON content type, and a CSRF request-header token; `no_cache`.

| Route | Path | Permission | Purpose |
|---|---|---|---|
| `editoria11y.api_config` | `/editoria11y/api/config` (GET) | `view editoria11y checker` | Return front-end checker config. |
| `editoria11y.api_report` | `/editoria11y/api/results/report` | `view editoria11y checker` | Store detected results for a page. |
| `editoria11y.api_dismiss` | `/editoria11y/api/dismiss` | `view editoria11y checker` | Record a "hidden"/"OK" dismissal. |
| `editoria11y.api_purge_page` | `/editoria11y/api/purge/page` | `manage editoria11y results` | Delete stored results for a page. |
| `editoria11y.api_purge_dismissals` | `/editoria11y/api/purge/dismissal` | `manage editoria11y results` | Reset dismissals. |

Controllers: `ApiController` (report/dismiss/purge) and `Ed11yConfigController` (config).
Backing services: `editoria11y.api` (`Api.php`), `editoria11y.dismissals_on_page`. These are
internal endpoints for the JS library, not a general public REST API.
