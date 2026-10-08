# Configure purge control

Settings form `PurgeControlSettings` (`src/Form/PurgeControlSettings.php`, a `ConfigFormBase`) at
route `purge_control.purge_settings` →
`/admin/config/development/performance/purge/purge-control`, permission
`administer site configuration`. It appears as a local task ("Purge Control Settings") under
`system.performance_settings` (`purge_control.links.task.yml`). It edits one config object,
`purge_control.settings` (the class constant `PurgeControlSettings::SETTINGS`).

## Config object `purge_control.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `disable_purge` | boolean | `FALSE` | The kill switch. `TRUE` = purging is paused. |
| `purge_auto_control` | boolean | `TRUE` | Automation flag. Gates `autoEnablePurge()`/`autoDisablePurge()` and enables cron auto-recovery. |

Defaults come from `config/install/purge_control.settings.yml`; schema is
`config/schema/purge_control.schema.yml` (config_object `purge_control.settings`).

Form checkboxes: "Automate control of enabling and disabling of purge." → `purge_auto_control`;
"Disable purging." → `disable_purge` (description: "Disables purging for all purgers.").

## How the pause is actually enforced

Setting `disable_purge` alone changes nothing in Purge by itself — the enforcement is the Purge
diagnostic check `PurgeEnabledCheck` (`src/Plugin/Purge/DiagnosticCheck/PurgeEnabledCheck.php`,
`@PurgeDiagnosticCheck` id `purge_enabled`). Its `run()` reads `disable_purge`:

- `disable_purge == TRUE` → recommendation "Purging is disabled.", returns `SEVERITY_ERROR`.
- otherwise → "Purging is enabled.", returns `SEVERITY_OK`.

A Purge diagnostic check at `SEVERITY_ERROR` marks the Purge system as "on fire", which blocks
Purge's processors from draining the queue and blocks queuers — i.e. invalidations stop being sent
to the external cache/CDN while paused. Nothing is back-filled on resume: items changed while paused
were never queued for invalidation, so plan a full/everything invalidation after re-enabling.

## Cron auto-recovery (`purge_auto_control`)

`hook_cron` (`purge_control_cron` in `purge_control.module`) calls
`purge_control.purge_control` → `autoEnablePurge()`. That re-enables purging (sets
`disable_purge = FALSE`) **only if** `purge_auto_control` is TRUE. This is a safety net: if purge was
paused and left paused, the next cron run turns it back on. To pause across a deployment, first turn
automation OFF (`drush pc disa`) so cron does not undo the pause, then disable purge
(`drush pc disp`).

## Set the flags via Drush or PHP

Drush (see [../drush/commands.md](../drush/commands.md)):

```
drush pc disa   # purge_auto_control = FALSE (stop cron auto-recovery)
drush pc disp   # disable_purge = TRUE  (pause)
drush pc enp    # disable_purge = FALSE (resume)
drush pc ena    # purge_auto_control = TRUE
```

PHP via the service:

```php
$pc = \Drupal::service('purge_control.purge_control');
$pc->setAutomation(FALSE);   // purge_auto_control = FALSE
$pc->disablePurge();         // disable_purge = TRUE, logs "Purging is disabled."
// ... bulk work ...
$pc->enablePurge();          // disable_purge = FALSE, logs "Purging is enabled."
$pc->setAutomation(TRUE);
```

Or set config directly:

```php
\Drupal::configFactory()->getEditable('purge_control.settings')
  ->set('disable_purge', TRUE)
  ->set('purge_auto_control', FALSE)
  ->save();
```
