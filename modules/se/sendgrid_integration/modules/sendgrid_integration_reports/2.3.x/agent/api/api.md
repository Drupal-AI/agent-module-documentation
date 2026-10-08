# Programmatic API — the reports `Api` service

Service id `sendgrid_integration_reports.api` → `Drupal\sendgrid_integration_reports\Api`
(constructor args: `config.factory`, `messenger`, `logger.factory`, `module_handler`, `cache_factory`).
On construction it resolves the SendGrid key from `sendgrid_integration.settings` `apikey` (through
the Key module when enabled) and warns if none is set. All calls hit `https://api.sendgrid.com/v3/`
with a `Bearer` token via Guzzle, sanitize the response with `Xss::filter`, cache into the
`sendgrid_integration_reports` bin, and return `[]` on error / missing key.

```php
/** @var \Drupal\sendgrid_integration_reports\Api $api */
$api = \Drupal::service('sendgrid_integration_reports.api');
```

## Methods

| Method | SendGrid endpoint | Returns |
|---|---|---|
| `getStats($cid, array $categories = [], $start_date = NULL, $end_date = NULL, $refresh = FALSE, $subuser = '')` | `stats` or `categories/stats` | `['global' => [ per-day metrics… ]]` — opens, clicks, delivered, bounces, spam_reports, unique_opens, invalid_emails, blocks, deferred, unsubscribes, etc. |
| `getStatsBrowser($subuser = '')` | `browsers/stats` | `[browser => click count]` |
| `getStatsDevices($subuser = '')` | `devices/stats` | `[device => open count]` |
| `getBouncesBySubuser($startTime = 0, $endTime = 0, $subuser = '')` | `suppression/bounces` | `[username => bounces]` (iterates subusers) |
| `getSubusers()` | `subusers` | array of subuser objects (paged by 500) |

Date range / aggregation for stats come from `sendgrid_integration_reports.settings`
(`start_date`, `end_date`, `aggregated_by`) unless overridden by args; defaults are last 30 days by
day. Pass `$refresh = TRUE` to `getStats()` to bypass the cache. A non-empty `$subuser` /
`$onBehalfOf` sends an `on-behalf-of` header so you can report on a specific SendGrid subuser.

The `SendGridReportsController` (route `sendgrid_integration_reports.reports`) is the built-in
consumer: it calls `getStats('sendgrid_reports_global')`, `getStatsBrowser()`, and
`getStatsDevices()` and renders charts + tables.
