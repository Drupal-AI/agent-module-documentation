<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command & cron service

## Drush

| Command | Alias | Effect |
|---|---|---|
| `drush scheduled_publish:doUpdate` | `schp` | Run all **due** scheduled moderation transitions now. |

`ScheduledPublishCommands::doUpdate()` simply calls the cron service and logs
"Scheduled publish updates done." Use it in deploy hooks/CI, or to test scheduling without
waiting for cron.

```bash
drush schp
# or
drush scheduled_publish:doUpdate
```

## Cron service

- Service id **`scheduled_publish.update`**, class
  `Drupal\scheduled_publish\Service\ScheduledPublishCron`.
- `doUpdate()` iterates bundles/fields of type `scheduled_publish`, finds entities whose
  scheduled `value` datetime is in the past, and applies the stored `moderation_state`
  transition (via content_moderation), saving a new revision.
- It runs automatically on **`hook_cron`** (every Drupal cron run). For finer scheduling the
  module ships an optional `ultimate_cron.job.scheduled_publish_cron` job (enable Ultimate Cron
  to use it).

Call it from code:

```php
\Drupal::service('scheduled_publish.update')->doUpdate();
```

No other Drush commands are provided.
