# Drush commands

Registered in `drush.services.yml` → `\Drupal\scheduler\Commands\SchedulerCommands`
(delegates to the `scheduler.manager` service).

- **`scheduler:cron`** (aliases `scheduler-cron`, `sch-cron`) — run Scheduler's lightweight cron
  (publish + unpublish pass only). Options: `--nomsg` (suppress the terminal "completed" message),
  `--nolog` (do not write start/complete messages to dblog). Use in an OS cron job to process
  scheduled changes more frequently than full site cron.

- **`scheduler:entity-update`** (aliases `scheduler-entity-update`, `sch-ent-upd`, `sch-upd`) —
  add the Scheduler `publish_on` / `unpublish_on` base fields for entity types now covered by a
  plugin. Run after installing a module that adds a `SchedulerPlugin`.

- **`scheduler:entity-revert`** (aliases `scheduler-entity-revert`, `sch-ent-rev`, `sch-rev`) —
  remove Scheduler fields and third-party settings. `--types=` takes a comma-separated list of
  entity type ids (default: all types needing reverting).

Use standard `-q` for quiet output on the update/revert commands.
