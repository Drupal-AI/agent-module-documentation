<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Sendgrid

Settings form `Drupal\sendgrid\Form\SettingsForm` (a `ConfigFormBase`) at route
`sendgrid.settings_form` → `/admin/config/services/sendgrid/settings` (permission `administer
sendgrid`). Edits the single config object `sendgrid.settings`
(`SendgridHandlerInterface::CONFIG_NAME`).

## Config keys (`sendgrid.settings`)

| Key | Type | Form field | Meaning |
|---|---|---|---|
| `api_key` | string | "Sendgrid API Key" (required) | The SendGrid API key. If the `key` module is enabled the field becomes a `key_select` filtered to `type = authentication`, so the value stored is a **Key entity id**, not the raw secret. Without `key`, the raw key string is stored in config. |
| `debug_mode` | bool | "Enable Debug Mode" | Log every successful send/queue (notice level) via logger channel `sendgrid`. |
| `ip_pool_name` | string | "IP Pool Name" (under *Mail options*) | Passed to the pre-send event; see below. |
| `format_filter` | string | "Format filter" (under *Advanced settings*) | A text-format id; when set, the body is run through `check_markup($body, $format, $langcode)` during `format()`. Empty = None. |
| `use_theme` | bool | "Use theme" (under *Advanced settings*) | Wrap the HTML body with a theme function; see [theme/theme.md](../theme/theme.md). |

Install defaults (`config/install/sendgrid.settings.yml`): all empty/false. Schema:
`config/schema/sendgrid.schema.yml` (`config_object` with the five mappings above).

### Set it with Drush / PHP

```bash
drush config:set sendgrid.settings api_key '<KEY-OR-KEY-ID>' -y
drush config:set sendgrid.settings debug_mode 1 -y
```

```php
\Drupal::configFactory()->getEditable('sendgrid.settings')
  ->set('api_key', 'my_sendgrid_key')   // Key entity id when the key module is on.
  ->set('debug_mode', TRUE)
  ->set('ip_pool_name', '')
  ->set('format_filter', '')             // e.g. a text format id.
  ->set('use_theme', FALSE)
  ->save();
```

The `SettingsForm::submitForm()` copies exactly these five keys from form state into
`sendgrid.settings` and saves.

## Key module integration

`key` is a dev/recommended dependency (`drupal/key ^1`). When enabled, store the API key as a Key
entity (any `authentication` key type / provider — e.g. environment variable or file) and select it in
the form. At runtime `SendgridHandler::getApiKey()` resolves the config value: if `key.repository` is
available and `getKey($api_key)` returns a Key with a non-empty value, that value is used; otherwise the
stored string is treated as the literal key. The repository is injected optionally via a
`setKeyRepository('@?key.repository')` service call, so the module works with or without `key`.

## Selecting the mail plugin (requires `mailsystem`)

This module does not switch the mailer by itself beyond `hook_install`, which registers `sendgrid`
in `system.mail`'s `interface` map. In practice choose the plugin through the **Mail System** module at
`/admin/config/system/mailsystem`:

- `sendgrid_mail` — send synchronously through the API on each mail.
- `sendgrid_queue_mail` — enqueue the message; a cron QueueWorker delivers it (see
  [api/mail-handler.md](../api/mail-handler.md)).

## Test email form

Route `sendgrid.test_email_form` → `/admin/config/services/sendgrid/settings/test`
(`Drupal\sendgrid\Form\TestEmailForm`, permission `administer sendgrid`). Sends a message via
`mail_manager->mail('sendgrid', 'test_form_email', …)` with To / body / optional attachment (the core
`druplicon.png`) / Reply-To / CC / BCC. Warns if the current Mail System sender plugin is not a
`sendgrid_*` one. On failure it links to the log (dblog) if available.
