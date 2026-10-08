# Configure Mailchimp Transactional

Admin form: **`admin/config/services/mailchimp_transactional`** (route
`mailchimp_transactional.admin`, `AdminSettingsForm`, permission
`administer mailchimp transactional`). A "Send Test Email" tab lives at
`.../mailchimp_transactional/test` (route `mailchimp_transactional.test`, gated by the two access
checks — see permissions doc — so it only works once an API key is set and Mail System points at
this mailer).

## The settings object — `mailchimp_transactional.settings`

Config keys (schema `mailchimp_transactional.schema.yml`; defaults from
`config/install/mailchimp_transactional.settings.yml`, except `from_email`/`from_name` which are
set to the site mail/name on install):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Mailchimp Transactional API key. **Required** for real sends and for the test/config access checks. |
| `from_email` | string | site mail | Sender email (Mailchimp needs a configured/verified from address). |
| `from_name` | string | site name | Sender name. |
| `subaccount` | string | `''` | Subaccount id (`_none` or empty = no subaccount). |
| `filter_format` | string | `''` | If set, `check_markup()` is applied to the body with this text format. |
| `track_opens` | boolean | `true` | Track email opens. |
| `track_clicks` | boolean | `true` | Track link clicks. |
| `url_strip_qs` | boolean | `false` | Strip query strings from tracked URLs. |
| `analytics_campaign` | string | `''` | Google Analytics campaign name. |
| `analytics_domains` | string | (unset) | Comma-separated GA domains. |
| `batch_log_queued` | boolean | `true` | Log a notice when a message is queued (async). |
| `queue_worker_timeout` | integer | `15` | Cron time budget for the queue worker (see `hook_queue_info_alter`). |
| `log_defaulted_sends` | boolean | `false` | Log when a mail key used this mailer only because it is the site default. |
| `api_timeout` | integer | `60` | API request timeout (seconds). |
| `api_classname` | string | `\Drupal\mailchimp_transactional\DrupalMailchimpTransactional` | Class wrapping the transactional library. |
| `mail_key_denylist` | string | `user_password_reset` | Comma-separated mail keys whose content is not stored/viewable (sets `view_content_link` false). |
| `process_async` | boolean | `false` | Queue mail into `mailchimp_transactional_queue` and send on cron instead of immediately. |

Read/write:

```
drush config:get mailchimp_transactional.settings
drush config:set mailchimp_transactional.settings process_async true
```

## Wire it up as the mailer (Mail System)

The module only registers mail plugins; you must select them in **Mail System**
(`admin/config/system/mailsystem`, config `mailsystem.settings`):

- Set the site-wide (or a module/key's) **sender** and/or **formatter** to
  `mailchimp_transactional_mail` (or `mailchimp_transactional_test_mail`).

```
drush config:set mailsystem.settings defaults.sender mailchimp_transactional_mail
```

On install, if the `mandrill` module was present, existing Mandrill settings, permissions, and
Mail System assignments are migrated automatically.

## API key handling

Store the key out of config where possible. This project's convention: keep it in an env var and
reference it (settings.php `getenv()` or a Key entity). Whatever the source, the effective value
must land in `mailchimp_transactional.settings:api_key` for the mailer and the access checks to
work.
