<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a download is counted

There is **no** download-serving route in this module. Files are delivered by Drupal core's
private-file route `system.files`; Download Count only *observes* that delivery and records it.

## The subscriber
`Drupal\download_count\EventSubscriber\DownloadCountSubscriber` (service `download_count_subscriber`)
subscribes to `KernelEvents::RESPONSE` → `onResponse()`.

```php
public function onResponse(ResponseEvent $event) {
  if (!$event->isMainRequest() || $this->routeMatch->getRouteName() !== 'system.files') {
    return;
  }
  $request = $event->getRequest();
  $uri = $this->streamWrapperManager->normalizeUri($request->get('scheme') . '://' . $request->get('file'));
  $file = $this->fileRepository->loadByUri($uri);        // managed file entity by URI
  _download_count_track_file_download($file, 'download', $this->currentUser);
}
```

It runs only on the `system.files` route and resolves the served URI back to a **managed file
entity** via `FileRepositoryInterface::loadByUri()`. Injected services: `AccountProxyInterface`,
`FileRepositoryInterface`, `RouteMatchInterface`, `StreamWrapperManagerInterface`.

## The tracking function
`_download_count_track_file_download($entity, $operation, $account)` in `download_count.module`
runs when `$operation == 'download'` and performs, in order:

1. **Extension exclusion.** Reads `download_count_excluded_file_extensions` (space-separated,
   default `jpg jpeg gif png`); if the file's extension is in the list, returns without counting.
2. **Skip permission.** If `$account` has `skip download counts`, it logs a watchdog notice
   (uid, filename, IP) and returns without inserting a counter row.
3. **Flood control.** If `download_count_flood_limit > 0`, checks
   `flood->isAllowed('download_count-fid_' . $fid, $limit, $window)`; if not allowed, returns.
   Window comes from `download_count_flood_window`. Default limit `0` = flood control off.
4. **Resolve the host entity.** `file_get_file_references($entity, NULL, FIELD_LOAD_REVISION, NULL)`
   yields the referencing entity's type + id. If the file has **no references, nothing is
   recorded** (only file-field-attached files are counted).
5. **Insert** one row into `download_count` via the DB API (`->insert()->fields([...])`):
   `fid`, `uid`, `type`, `id`, `ip_address` (`request->getClientIp()`), `referrer`
   (`$_SERVER['HTTP_REFERER']` or "Direct download"), `timestamp`.
6. **Register flood** event and log a watchdog notice.
7. **Rules event.** If the `rules` module is enabled, invokes
   `rules_invoke_event('download_count_file_download', $file, $account, $host_entity)`.

Note: user 1 downloads are effectively excluded because user 1 passes the `skip download counts`
check (all permissions). No SQL is string-built; all queries use the DB API with placeholders.

## Storage tables (`download_count.install` `hook_schema()`)
| Table | Purpose | Key columns |
|---|---|---|
| `download_count` | one raw row per download | `dcid` (PK), `fid`, `uid`, `type`, `id`, `ip_address`, `referrer`, `timestamp`; indexed on fid/uid/type/id/ip_address/timestamp and `(fid,type,id)` |
| `download_count_cache` | per-file, per-day totals | `dcc_id` (PK), `fid`, `type`, `id`, `date`, `count`; indexed on fid/type/id/date and `(fid,type,id,date)` |

`hook_uninstall()` deletes the `download_count.settings` config and the
`download_count_last_cron` state; it does **not** prune the tables while the module is enabled.

## Cron caching pipeline
`download_count_cron()` selects rows in `download_count` newer than the `download_count_last_cron`
state value, grouped per `(type, id, fid, day)` with a `COUNT(dcid)`, and pushes each grouped
record onto the `download_count` queue, then advances `download_count_last_cron`.

Queue worker `Drupal\download_count\Plugin\QueueWorker\DownloadCountCacheProcessor`
(`@QueueWorker id="download_count", cron={"time"=60}`) merges each record into
`download_count_cache` with `->expression('count', 'count + :inc', [':inc' => $data->count])`.

Reports and blocks read `download_count_cache` (aggregates) rather than scanning the raw log.
Clearing the cache (route `download_count.clear`) truncates `download_count_cache` and resets
`download_count_last_cron` to 0; it is rebuilt on the next cron run.
