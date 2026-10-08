<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mailgun

## Admin form & route

- Route `mailgun.admin_settings_form` → `/admin/config/services/mailgun/settings`
  (form `MailgunAdminSettingsForm`), permission **`administer mailgun`**.
- Test email form: `/admin/config/services/mailgun/settings/test` (`mailgun.test_email_form`).

## `mailgun.settings` config object

Schema `mailgun.settings` (`config/schema/mailgun.schema.yml`); defaults from
`config/install/mailgun.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Mailgun private API key (store securely — see below). |
| `api_endpoint` | string | `https://api.mailgun.net` | API base URL (US or EU region). |
| `working_domain` | string | `_sender` | Mailgun sending domain; `_sender` derives it from the From address. |
| `debug_mode` | bool | `false` | Log full API request/response. |
| `test_mode` | bool | `false` | Mailgun test mode: accept but do not actually deliver (log instead). |
| `tracking_opens` | string | `''` | `''` (use domain setting) / `yes` / `no`. |
| `tracking_clicks` | string | `''` | `''` / `yes` / `no`. |
| `tracking_exception` | string | `user:password_reset` | Mail keys excluded from tracking. |
| `format_filter` | string | `plain_text` | Text-format id used to render the message body. |
| `use_queue` | bool | `false` | Queue mail and send on cron instead of immediately. |
| `use_theme` | bool | `false` | Wrap mail in the site theme. |
| `tagging_mailkey` | bool | `false` | Tag messages by Drupal mail key for Mailgun analytics. |

Read/write examples:

```bash
drush cget mailgun.settings use_queue
drush cset mailgun.settings use_queue true -y
drush cset mailgun.settings test_mode true -y
drush cset mailgun.settings tracking_opens yes -y
```

## Wire it as the mailer (Mailsystem)

Mailgun does not override mail delivery by itself — you select its Mail plugin through the
**Mailsystem** module (`/admin/config/system/mailsystem`, config `mailsystem.settings`):

- Set the **sender** (and usually **formatter**) to `mailgun_mail` (immediate) or
  `mailgun_queue_mail` (queued) — globally under `defaults`, or per module/mail-key under
  `modules`.

```bash
# route ALL mail through Mailgun immediately:
drush cset mailsystem.settings defaults.sender mailgun_mail -y
drush cset mailsystem.settings defaults.formatter mailgun_mail -y
```

## Store the API key securely

Do not commit the key. Prefer an environment variable / Key entity:

```bash
ddev dotenv set .ddev/.env --mailgun-api-key=<value>   # then ddev restart
```

Then either reference `getenv('MAILGUN_API_KEY')` from settings, or (where supported) set
`mailgun.settings api_key` from the env var during deployment. Keep `.ddev/.env` out of VCS.
