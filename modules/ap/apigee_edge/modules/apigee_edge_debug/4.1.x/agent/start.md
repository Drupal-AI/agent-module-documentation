# Apigee Edge Debug (apigee_edge_debug) — agent index

Developer/debug helper for **apigee_edge**. Logs every Apigee Management API call (request, response,
transfer stats) made through the module's SDK connector to the `apigee_edge_debug` logger channel, so
you can inspect exactly what Drupal sends to and receives from Apigee. The message is rendered by a
pluggable **formatter** and, by default, sanitized so credentials are not written to the log.

- Depends on `apigee_edge`. No permissions of its own (its config form uses `administer apigee edge`).
  No Drush.
- `configure` route: **`apigee_edge_debug.settings`** (`/admin/config/apigee-edge/debug`).
- Provides a plugin type: **`DebugMessageFormatter`**.

## Solution docs
- **Turn on logging, choose a formatter, sanitization options, log format tokens** →
  [configure/logging.md](configure/logging.md)
- **The formatter plugin type + the shipped formatters, and how to add one** →
  [plugins/formatters.md](plugins/formatters.md)

## Key facts
- Config object `apigee_edge_debug.settings`: `formatter` (default `full_html`), `log_message_format`,
  `mask_organization` (default **true**), `remove_credentials` (default **true**).
- It **decorates** `apigee_edge.sdk_connector` (`Drupal\apigee_edge_debug\SDKConnector`) to tag every
  request with header `X-Apigee-Edge-Api-Client-Profiler`, and adds an HTTP client middleware
  `apigee_edge_debug.client_profiler` (`ApiClientProfiler`) that logs on Guzzle `on_stats`.
- Only requests carrying that header (i.e. Apigee SDK calls) are logged; others are ignored.
- Formatter plugins: `full_html`, `simple`, `curl` (+ a Devel/Kint profiler variant).
