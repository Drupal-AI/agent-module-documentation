# Programmatic API — the `csp_log` service

Service id `csp_log` → `\Drupal\csp_log\CspLogService` (interface
`\Drupal\csp_log\CspLogServiceInterface`). Constructed with the `@database` connection and
a dedicated `logger.channel.csp_log` channel. Backs both admin forms and the report
endpoint controller.

```php
$svc = \Drupal::service('csp_log'); // or inject 'csp_log'
```

Constants on the interface:
- `CspLogServiceInterface::DATABASE_TABLE` = `'csp_log'`.
- `CspLogServiceInterface::REQUIRED_REPORT_KEYS` = `['document-uri', 'effective-directive', 'blocked-uri']`.

## Methods

### `insertLog(object $data, string $type): void`
Stores one violation. `$data` is the decoded CSP report object (hyphenated keys, e.g.
`$data->{'document-uri'}`). Throws `\InvalidArgumentException` if any of the three required
keys are empty. `$type` is normalized: `'enforce'` stays `enforce`, anything else becomes
`reportOnly`. Stored fields are truncated to 255 chars; the full object is saved as
pretty-printed JSON in the `report` blob; `timestamp` is `time()`.

### `fetchLogs(array $filters, int $amount = 0, array $sort = []): array`
Returns individual log rows (`id`, `timestamp`, `document_uri`, `referrer`, `blocked_uri`,
`effective_directive`). `$amount > 0` adds a `PagerSelectExtender` limit; `$sort` (a table
header array) adds a `TableSortExtender`.

### `aggregateLogs(array $filters, int $amount = 0, array $sort = []): array`
Returns rows grouped by `blocked_uri` + `effective_directive` with a `COUNT(id)` as
`amount`. Same pager/sort behavior.

### `removeLogs(string $type, int $endDate, int $startDate = 0): int`
Deletes rows of `$type` with `timestamp` between `$startDate` and `$endDate` (unix
timestamps). Returns the number of deleted rows. This is what `csp_log_cron()` calls.

## Filters accepted by fetch/aggregate

Keys in `$filters` (all optional): `search` (LIKE across document_uri, referrer,
blocked_uri, effective_directive), `type` (`enforce`/`reportOnly`), `date_from`,
`date_to` (parsed with `strtotime`). Aggregate additionally honors `min_amount` /
`max_amount` (HAVING on the count).

## Notes

- No Drush commands and no invited hooks (`*.api.php`) are provided.
- The endpoint controller `\Drupal\csp_log\Controller\LogReportUri::log()` decodes the
  request body, unwraps `csp-report`, calls `insertLog()`, and returns 202 / 400 / 500.
