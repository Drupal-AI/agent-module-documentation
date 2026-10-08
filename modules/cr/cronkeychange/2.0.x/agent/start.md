# Cron Key Change — agent index

Utility module to regenerate Drupal's cron key (state `system.cron_key`, used in the external
`/cron/<key>` URL). No config schema, no permissions of its own, no dependencies. The UI is a
fieldset injected into the core Cron settings form; a Drush command does the same from CLI.

- **Regenerate the key via UI / the core cron form, plus the `system.cron_key` state internals** →
  [configure/cron-key.md](configure/cron-key.md)
- **`drush cronkeychange` for CLI/automation** → [drush/commands.md](drush/commands.md)

Key facts:
- `configure` route = `system.cron_settings` (`/admin/config/system/cron`), gated by core's
  `administer site configuration` permission (this module defines no permission).
- New key = `Crypt::randomBytesBase64(55)` written to `\Drupal::state()->set('system.cron_key', …)`.
- Core function: `cronkeychange_generate_new_key()` (in `cronkeychange.module`) — used by both the
  form submit handler and the Drush command.
