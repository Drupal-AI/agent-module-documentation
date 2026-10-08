# Drush commands

Defined in `Drupal\danse\Drush\Commands\DanseCommands` (Drush attribute style, service-injected
`danse.service`). Enable the base `danse` module.

| Command | Alias | Behavior |
|---|---|---|
| `danse:notifications:create` | `dnc` | Runs `danse.service::createNotifications()` — turn all unprocessed `danse_event`s into `danse_notification`s now, instead of waiting for cron. |
| `danse:event-tracking:status` | — | Reports whether event tracking is paused (state key `danse.event_tracking.paused`). |
| `danse:event-tracking:pause` | — | `danse.service::pause()` — stop recording new events (existing data untouched). |
| `danse:event-tracking:resume` | — | `danse.service::resume()` — resume recording events. |

Examples:

```bash
drush dnc                              # create outstanding notifications
drush danse:event-tracking:pause       # e.g. before a bulk import
drush danse:event-tracking:status
drush danse:event-tracking:resume
```

Pausing is useful around migrations or bulk operations that would otherwise generate a flood of events;
while paused, `PluginBase::createEvent()` returns early. Pruning is not a Drush command — it runs on
cron or via the Prune confirm form (`/admin/config/system/danse/prune`).
