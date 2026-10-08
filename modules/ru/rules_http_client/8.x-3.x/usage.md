Rules HTTP Client adds a single Rules action, "Request HTTP data", that lets a site's Rules configurations send an HTTP request (GET/POST/PUT/DELETE/etc.) to a URL and capture the response body for use later in the same Rule.

---

The module ships one `@RulesAction` plugin (`rules_http_client`, class `Drupal\rules_http_client\Plugin\RulesAction\RulesHttpClient`) that wraps Drupal's shared Guzzle `http_client` service. Site builders configure the action inside a reaction rule or rules component: they supply the URL, HTTP method, request headers (as `name: value` lines), a request body (as `param=value` pairs), a redirect limit, and a timeout — each of which can be a fixed value or a Rules data selector resolved at execution time. The action performs the request server-side and exposes the response body as a provided context value (`http_response`, a string) that downstream Rules actions can save, parse, or act on. An optional per-action Debug flag records the full request/response (method, URL, headers, bodies) to the `rules_http_client` logger channel, and — when the site-wide "Show responses" setting is on and the acting user holds Rules' debug permission — echoes those details to the UI as a status message. A settings form at `/admin/config/workflow/rules/http-client-settings` (permission `administer rules`) controls the "Show responses" toggle and the maximum logged response-body size. No extra database tables, entities, permissions, or Drush commands are added; everything is driven from the Rules UI. It requires the Rules module (`drupal/rules:^4.0`) and Drupal 10.3+ or 11.

---

- Call a remote REST API from a reaction rule when a node is created, updated, or deleted.
- POST content to an external service (CRM, marketing platform, analytics) whenever an entity event fires.
- Send an outbound webhook to a third-party endpoint on a Rules-triggered event.
- Fetch remote XML and combine it with Rules XPath Parser / Views XML Backend to parse the response.
- Retrieve JSON from an external API and store the response string in an entity field via a follow-up Rules action.
- Notify a chat/incident service (e.g. a Slack-style webhook URL) when a business condition is met.
- Trigger a rebuild or cache-purge on a downstream/decoupled front end by hitting its API.
- Synchronize a just-saved node to a remote Drupal site by POSTing to its REST endpoint.
- Ping a monitoring/health-check URL on a scheduled Rules component (via Rules + a scheduler).
- Submit form-style data to a remote endpoint using the `param=value` request-body syntax.
- Set a custom `Accept` header (e.g. `application/xml`) so a remote service returns the desired format.
- Send authenticated requests by supplying an `Authorization` header line in the action configuration.
- Follow a bounded number of redirects by tuning the "Max Redirect" context value.
- Guard against slow endpoints by setting a per-request "Timeout" (seconds).
- Capture the response body into a Rules variable (`http_response`) for conditional branching.
- Chain multiple HTTP calls within one Rule by adding several "Request HTTP data" actions.
- Debug an integration by enabling the action's Debug flag and reading the `rules_http_client` log channel.
- Post a status update to a social or messaging API when a comment or order is created.
- Kick off an external workflow/automation (CI, Zapier-style webhook) from a Drupal content event.
- Report a newly published node's URL to a search-indexing or CDN invalidation API.
- Use the action inside a reusable Rules component so multiple rules can share one HTTP call.
