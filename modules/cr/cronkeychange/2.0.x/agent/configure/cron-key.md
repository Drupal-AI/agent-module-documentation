# Regenerating the cron key

The module has **no settings of its own**. It implements
`hook_form_system_cron_settings_alter()` to add a "Change cron key" fieldset to the core Cron
settings form.

## Where
- Route: `system.cron_settings` → path `/admin/config/system/cron`.
- Access: core `administer site configuration` permission (unchanged by this module).
- The fieldset shows:
  - **Current cron key** — a read-only item printing `\Drupal::state()->get('system.cron_key')`.
  - **Generate new key** — a submit button (`cronkeychange_generate_submit`).

## What "Generate new key" does
Calls `cronkeychange_generate_new_key()` (`cronkeychange.module`):
```php
$cron_key = Crypt::randomBytesBase64(55);
\Drupal::state()->set('system.cron_key', $cron_key);
// status message (web only) + \Drupal::logger('cronkeychange')->notice('New cron key generated.')
```
After saving, the external cron URL changes to `/cron/<new-key>`; any previously shared
`/cron/<old-key>` URL stops working immediately.

## Reading / setting the key programmatically
```php
$key = \Drupal::state()->get('system.cron_key');        // current key
\Drupal\cronkeychange\... // no service; just call the module function:
cronkeychange_generate_new_key();                        // rotate
```
The key lives in **state**, not config — it is not exported with `drush cex` and differs per
environment. There is no config schema and nothing to configure beyond pressing the button.
