# Drush commands

Registered via `drush.services.yml` →
`Drupal\cronkeychange\Commands\CronKeyChangeCommands`.

## `drush cronkeychange`
- No arguments, no options, no alias.
- Calls `cronkeychange_generate_new_key()` then prints `New cron key generated.`
- Regenerates `system.cron_key` (state) to a fresh `Crypt::randomBytesBase64(55)` value; when run
  from CLI it skips the Messenger status message but still logs a `cronkeychange` notice.
- To read the new value afterward: `drush state:get system.cron_key`.

Use it in deploy scripts or scheduled rotation:
```bash
drush cronkeychange && drush state:get system.cron_key
```
