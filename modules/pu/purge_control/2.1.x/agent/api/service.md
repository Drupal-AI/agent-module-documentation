# Service: `purge_control.purge_control`

Class `Drupal\purge_control\Services\PurgeControl` (`src/Services/PurgeControl.php`). Registered in
`purge_control.services.yml` with args `['@config.factory', '@logger.channel.purge_control']`. In its
constructor it holds an **editable** handle to `purge_control.settings`
(`$config_factory->getEditable(PurgeControlSettings::SETTINGS)`), so mutating methods persist
immediately with `->save()`.

## Methods

| Method | Behavior |
|---|---|
| `enablePurge()` | `setKillSwitch(FALSE)` → `disable_purge = FALSE`; logs info "Purging is enabled." |
| `disablePurge()` | `setKillSwitch(TRUE)` → `disable_purge = TRUE`; logs info "Purging is disabled." |
| `autoEnablePurge()` | Calls `enablePurge()` **only if** `isPurgeAutomated()`. Used by `hook_cron`. |
| `autoDisablePurge()` | Calls `disablePurge()` **only if** `isPurgeAutomated()`. |
| `isPurgeAutomated()` | Returns `(bool) purge_auto_control`. |
| `setAutomation(bool $value)` | Sets `purge_auto_control` and saves. |
| `setKillSwitch(bool $value)` | Sets `disable_purge` and saves. |

The `auto*` pair is the safe entry point for scripted/automated flows: it no-ops unless the site
operator has opted into automation via `purge_auto_control`. The plain `enablePurge()`/
`disablePurge()` are unconditional.

## Integration pattern: wrap a long Drush command

Pause purging around a bulk operation using Drush's pre/post-command hooks, so a migration or bulk
resave does not flood the queue with invalidations. Because `auto*` is used, this only fires when the
operator has automation enabled.

```php
use Consolidation\AnnotatedCommand\CommandData;

/**
 * @hook pre-command your-module:bulk-op
 */
public function preCommand(CommandData $commandData) {
  // Inject purge_control.purge_control via DI in real code.
  \Drupal::service('purge_control.purge_control')->autoDisablePurge();
}

/**
 * @hook post-command your-module:bulk-op
 */
public function postCommand($result, CommandData $commandData) {
  \Drupal::service('purge_control.purge_control')->autoEnablePurge();
}
```

## Enforcement note

The service only flips config booleans. Purging actually stops because the `purge_enabled`
diagnostic check reports `SEVERITY_ERROR` while `disable_purge` is TRUE, marking Purge's system "on
fire" and halting processors/queuers. See [../configure/settings.md](../configure/settings.md).
Invalidations skipped while paused are not back-filled — run an "everything" invalidation after
resuming.
