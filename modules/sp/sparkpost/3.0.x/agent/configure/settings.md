<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Sparkpost

Route `sparkpost.settings_form` → `/admin/config/services/sparkpost`, permission
`administer sparkpost`. Form: `Drupal\sparkpost\Form\SettingsForm` (a `ConfigFormBase` editing
`sparkpost.settings`).

## Fields (config object `sparkpost.settings`)

| Key | UI | Notes |
| --- | --- | --- |
| `api_key` | textfield "API Key" | The SparkPost API key. Rendered back into a plain textfield (not a password field). Until a key is set, only this field shows. |
| `api_hostname` | select "API Hostname" | `api.sparkpost.com` (US, default) or `api.eu.sparkpost.com` (EU). US and EU accounts are separate. |
| `sender` | email "From address" (required) | Sent as `content.from.email`. Must be a verified SparkPost sending address or mail is rejected. Any per-message `from` is moved to `Reply-To`. |
| `sender_name` | textfield "From name" | Sent as `content.from.name`. |
| `format` | select "Input format" | Optional Drupal text format run over the body (`check_markup`) before sending. |
| `debug` | checkbox "Debug" | On failure, exceptions are logged to watchdog (`watchdog_exception`). Default `true` in shipped config. |
| `async` | checkbox "Send asynchronous" | Queue the message instead of sending inline. See submodules/requeue.md. |
| `skip_cron` | checkbox "Skip queue on cron" | Only visible when `async` is on. Removes the `sparkpost_send` queue from cron (`hook_queue_info_alter`) so you drain it yourself (`drush queue:run sparkpost_send`). |

The form only reveals the option fields once an `api_key` is present. When a key is set it also
checks that Sparkpost is actually the selected mailer: if the **Mailsystem** module is enabled it
compares `mailsystem.settings` `defaults.sender` to `sparkpost_mail`; otherwise it compares
`system.mail` `interface.default`. If neither points at `sparkpost_mail` it shows a warning — the
module does **not** set itself as the backend automatically.

## Making Sparkpost the active mailer

- **Without Mailsystem:** set `system.mail` `interface.default` to `sparkpost_mail` (e.g. in
  `settings.php`: `$config['system.mail']['interface']['default'] = 'sparkpost_mail';`).
- **With Mailsystem:** choose the "Sparkpost mailer" plugin as the default sender (and/or per
  module/key) at `/admin/config/system/mailsystem`.

## API-key handling (recommended)

The key lives in `sparkpost.settings` and is therefore exportable configuration. Prefer keeping
it out of committed config by overriding in `settings.php`, e.g.
`$config['sparkpost.settings']['api_key'] = getenv('SPARKPOST_API_KEY');`. Treat the key as a
live sending credential and scope it to transmission sending in the SparkPost dashboard.

## Test send

Route `sparkpost.test_mail_form` → `/admin/config/services/sparkpost/test`. Custom access
(`TestMailForm::access`): allowed only if an `api_key` is configured **and** the user has
`administer sparkpost`. Sends a sample message (via `hook_mail()` key `test_mail_form`), optionally
attaching `core/misc/druplicon.png`. A `config.factory.override` (`TestMailSystemOverride`) forces
the `sparkpost_mail` plugin for just this one mail key, so the test works even before you switch
the site-wide backend.
