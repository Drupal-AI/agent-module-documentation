<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoint intake protocol

Handled by `\Drupal\reporting\Controller\ReportingEndpoint::log($reporting_endpoint)` (route
`entity.reporting_endpoint.log`, path `/system/reporting/{reporting_endpoint}`, `_access: TRUE`).
Responses are always **empty-bodied** (`\Drupal\reporting\ReportingResponse`, a `Response` subclass
with no content) and a `ResponseSubscriber` listener stops propagation so nothing else rewrites them.

## Request handling / status codes

In order:

1. Endpoint **disabled** (`status = FALSE`) → **410 Gone**.
2. Not a **POST** → **405 Method Not Allowed** (methods aren't restricted on the route so an empty
   body can be returned instead of a rendered error page).
3. Body is not valid JSON / empty → **400 Bad Request**.
4. Dispatch on `Content-Type`:
   - `application/reports+json` → treated as a Reporting API batch (`storeReportToData`).
   - `application/csp-report` → legacy CSP `report-uri` payload (`storeReportUriData`), incl. Firefox.
   - anything else → **415 Unsupported Media Type**.
5. Success → **202 Accepted**.

## Report normalization

- **Reporting API** (`application/reports+json`) is an array of report objects; each must have
  `type`, `url`, and `body` or it is skipped. Missing `user_agent` is filled from the request's
  `User-Agent`; missing `age` defaults to `0`.
- **Legacy CSP** (`application/csp-report`) arrives as `{ "csp-report": { … } }`. The controller
  rewrites it into the Reporting API shape (`type: 'csp-violation'`, `url` = `document-uri`,
  `body` = the report) and maps the hyphenated CSP keys to the camelCase Reporting API keys
  (`document-uri`→`documentURL`, `blocked-uri`→`blockedURL`, `violated-directive`→`violatedDirective`,
  `script-sample`→`sample`, etc.), then sorts and forwards it through the same store path. (Safari
  sends single reports already in report-to format.)

## How reports are stored

Each valid report is logged (no custom DB table):

```php
\Drupal::logger('reporting')->info("@endpoint <br/>\n<pre>@data</pre>", [
  '@endpoint' => $reporting_endpoint->id(),
  '@data' => json_encode($report, JSON_PRETTY_PRINT),
]);
```

So a report becomes a **watchdog entry** with `type = reporting`, whose message embeds the endpoint
id and the pretty-printed JSON report. Placeholders are escaped by Drupal's logging/render layer.

## Reading reports back

- Admin table: `/admin/reports/reporting` (needs `dblog` + `access site reports`) — see
  `configure/endpoints.md`. It selects `watchdog` rows where `type = 'reporting'` and
  `message LIKE '@endpoint <br/>%'`, decoding `variables['@data']` to show type / disposition / location.
- Programmatically, query the `reporting` channel / `watchdog` `type = 'reporting'`.

## The advertised header (server → browser)

Separately from intake, `ResponseSubscriber::addReportToHeader()` sets on outgoing responses:

```
Reporting-Endpoints: <id>="<absolute /system/reporting/{id} URL>", …
```

for every enabled endpoint (structured-fields dictionary). This is what tells browsers where to send
reports in the first place. See `configure/endpoints.md` for caching and enable/disable behavior.
