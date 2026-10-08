<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending webhooks / queue (drush)

This module adds **no** drush commands of its own. It uses core queue + cron. Queue name: `page_refresh_webhook`.

Requests are queued on node save and normally sent on the next cron run. To flush them immediately with core commands:

```bash
drush queue:list                      # shows waiting items per queue
drush queue:run page_refresh_webhook  # send all pending webhook requests now
drush cron                            # or just run cron
```

Inspect / change config:

```bash
drush config:get page_refresh_webhook.settings
```

## Behavior notes

- **Endpoint down / server error / unreachable:** worker throws `SuspendQueueException`; items stay and retry next run (nothing lost).
- **Endpoint rejects the request (e.g. HTTP 403 `ClientException`):** item is dropped and the reason logged (a retry would fail the same way).
- **Same URL saved several times since last run:** sent once per run (deduped by `url|depth`).
- **Endpoint removed from config before sending:** queued requests are dropped.
- Uninstalling the module deletes the queue (`hook_uninstall`).

Logs: `/admin/reports/dblog` (channel `page_refresh_webhook`) or `drush watchdog:show`.

## Upgrading 1.x → 2.x

Run `drush updb` after updating: update `page_refresh_webhook_update_11201` casts the stored crawl depth from string to integer so `depth` is sent as a JSON number. Existing webhook config is otherwise preserved.
