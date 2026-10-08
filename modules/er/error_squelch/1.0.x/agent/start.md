<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error Squelch (error_squelch) — agent index

Removes on-screen Drupal **status, warning, and error messages** whose text matches an
admin-configured pattern list, filtering `$variables['message_list']` in
`hook_preprocess_status_messages()` before the status-messages template renders. Package
`Development`. **No module dependencies.** Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.0.0. Suppression is cosmetic only — it does not fix the underlying cause.

- **Settings form, config object, schema, route, permission, menu** →
  [config/settings.md](config/settings.md)
- **The filter mechanism: hook + `MessageSquelcher` service, matching, logging, test mode** →
  [api/message-squelcher.md](api/message-squelcher.md)
- **Drush commands (list / add / remove)** → [drush/commands.md](drush/commands.md)

## What it actually is

- One hook, OO: `ErrorSquelchHooks::preprocessStatusMessages()`
  (`src/Hook/ErrorSquelchHooks.php`, `#[Hook('preprocess_status_messages')]`), with a
  `#[LegacyHook]` procedural wrapper `error_squelch_preprocess_status_messages()` in
  `error_squelch.module` for core 10.3–11.0.
- One service `error_squelch.message_squelcher` = `Drupal\error_squelch\MessageSquelcher`
  (`src/MessageSquelcher.php`); `filter(array &$message_list)` does the removal. Plus a
  logger channel `logger.channel.error_squelch`.
- One config object `error_squelch.settings` (keys: `squelch_patterns` sequence, `use_regex`,
  `log_suppressed`, `test_mode` booleans). Schema in `config/schema/error_squelch.schema.yml`,
  install defaults in `config/install/error_squelch.settings.yml`.
- One form `ErrorSquelchSettingsForm` (`src/Form/`) at route `error_squelch.settings`
  (`/admin/config/development/error-squelch`), gated by permission **`administer error squelch`**
  (`restrict access: true`). Menu link under *Configuration → Development*.
- One Drush command class `ErrorSquelchCommands` (`src/Drush/Commands/`): `error-squelch:list`
  / `:add` / `:remove` (aliases `esl` / `esa` / `esrm`).
- **No entities, no plugins, no fields, no external calls, no eval, no queries.**
