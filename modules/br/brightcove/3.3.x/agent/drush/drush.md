# Brightcove Drush commands

Defined in `src/Drush/Commands/BrightcoveCommands.php` (registered via the module's
`extra.drush.services` for Drush ^12).

| Command | Alias | Does |
|---|---|---|
| `brightcove:sync-all` | `bcsa` | Initiates a full Brightcove→Drupal sync by enqueuing every API client's status queues (`BrightcoveUtil::runStatusQueues('sync', …)`) and processing the batch (`drush_backend_batch_process()`). Logs "Sync complete." or the exception. |

```bash
ddev drush brightcove:sync-all
ddev drush bcsa
```

This is the same sync that runs on cron (unless `brightcove.settings:disable_cron` is true) or from
the Status Overview page (`/admin/reports/brightcove`). There are no other Drush commands.
