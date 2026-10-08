# Scheduling: cron, settings and manual triggers (configure)

Digests are built by `hook_cron` (`webform_digests_cron()`), which reads config
**`webform_digests.settings`**. There is **no admin form** for these values — change them by
overriding the config in `settings.php` (as documented in the module README).

## `webform_digests.settings` keys

| Key | Default | Values | Effect |
|---|---|---|---|
| `cron.enabled` | `TRUE` | bool | If not strictly `TRUE`, `webform_digests_cron()` returns immediately and never queues. |
| `cron.frequency` | `'day'` | `'hour'` \| `'day'` \| `'week'` | Minimum gap between queue builds **and** the length of the submission window (`strtotime('- 1 <frequency>')`). |
| `cron.hour` | `9` | int (0–23) | Digests are only queued once the server hour (`date('G')`) has reached this value. |

Override example (`settings.php` / `settings.local.php`):

```php
$config['webform_digests.settings']['cron.enabled'] = FALSE;      // disable the built-in cron trigger
$config['webform_digests.settings']['cron.frequency'] = 'week';   // hour | day | week
$config['webform_digests.settings']['cron.hour'] = 9;
```

## How the cron gate works (`webform_digests_cron()`)

1. Return early unless `cron.enabled === TRUE`.
2. Read `State` `webform_digests.last_run` (0 if never run).
3. Compute `time_since_last_run` from `cron.frequency` (`hour` → 3600s, `day` → 86400s,
   `week` → 604800s).
4. If `now - last_run >= time_since_last_run` **and** `date('G') >= cron.hour`, call
   `webform_digests.queue_builder->queueSubmissions()` and set `State`
   `webform_digests.last_run = now`.

Because the window start is `strtotime('- 1 <frequency>', $endDate)`, a run at frequency `day`
digests submissions whose `changed` timestamp falls in the last 24h; `week` → last 7 days. The
send hour is server local time (`date('G')`), and the schedule is only as reliable as the site's
cron — a missed cron window silently produces no email.

## Manual / external triggering

Both of these call the same `WebformDigestsQueueBuilder::queueSubmissions()` and **ignore** the
`cron.enabled` / `cron.hour` gate (they always queue):

- **HTTP:** `GET /admin/structure/webform_digests/send` (route `webform_digests.send`,
  `Controller\DigestController::sendAction`). Requires permission **`send webform digest`**. Returns
  `{"queued": <n>}` JSON. The README suggests pointing an OS cron job at this URL when the built-in
  cron is disabled.
- **Drush:** `drush webform:queue-digests` (`Commands\WebformDigestsCommands::queueDigests`). A
  legacy Drush-8 command `queue-digests` also exists in `webform_digests.drush.inc`.

`queueSubmissions()` only **enqueues** one `webform_digest_queue` item per digest (payload:
`digest`, `start`, `end`). The messages are actually built and sent when the
`webform_digest_queue` QueueWorker processes those items — normally on the **next** cron run
(`cron = {"time" = 30}`), or via `drush queue:run webform_digest_queue`. See
[../api/services.md](../api/services.md) for the worker's logic.
