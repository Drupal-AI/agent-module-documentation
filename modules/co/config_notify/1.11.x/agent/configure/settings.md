# Configure config_notify

Settings form: `\Drupal\config_notify\Form\ConfigNotifySettingsForm`
Route: `config_notify.settings` → `/admin/config/development/configuration/notify`
Permission: `synchronize configuration` (core). Config object: `config_notify.settings`.

Opening the form runs a drift check immediately and shows a warning message ("There are
configuration changes." / "There are no configuration changes."). The **"Notify now"** submit
button only appears when drift is currently detected; it saves the form and sends immediately.

## Config keys (`config_notify.settings`)

| Key | Type | Meaning |
|-----|------|---------|
| `cron` | bool | Send notifications from `hook_cron` when drift is detected. |
| `daily` | bool | On cron, send at most one notification per calendar day (compares `date('Ymd')` of `last_sent`). |
| `email` | bool | Enable email notification. |
| `email_to` | string (email) | Recipient. Empty → falls back to `system.site` `mail` (site email). |
| `slack` | bool | Enable Slack notification. Only effective if the `slack` module is enabled and its webhook is configured; the checkbox is disabled/hidden otherwise. |
| `list_changes` | bool | Include the list of changed config **object names** in the message body. |
| `list_changes_limit` | int | Max number of names listed; `0` = unlimited. Extra names collapse to "and N more changes." |
| `add_host` | bool | Prepend a host label to the message. |
| `custom_host_value` | string | Host label used when `add_host` is on. Empty → current `scheme://host` from the request. |

There is **no `config/install` default and no schema file**, so every key is `null` until the
form is saved once (or you set it explicitly). `cron`, `email`, and `slack` all default to
off, so a fresh install sends nothing until configured.

## Set without the UI

Drush:

```
drush config:set config_notify.settings cron 1 -y
drush config:set config_notify.settings email 1 -y
drush config:set config_notify.settings email_to devs@example.com -y
drush config:set config_notify.settings daily 1 -y
drush config:set config_notify.settings list_changes 1 -y
drush config:set config_notify.settings list_changes_limit 20 -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('config_notify.settings')
  ->set('cron', TRUE)
  ->set('daily', TRUE)
  ->set('email', TRUE)
  ->set('email_to', 'devs@example.com')
  ->set('list_changes', TRUE)
  ->set('list_changes_limit', 20)
  ->set('add_host', TRUE)
  ->set('custom_host_value', 'PROD')
  ->save();
```

## What happens at runtime

- **Drift check** — `NotifierService::checkChanges()` transforms the sync storage
  (`config.storage.sync`) through `config.import_transformer`, then compares it against the
  active storage (`config.storage`) with a core `StorageComparer`. Returns `TRUE` when the sync
  list is non-empty and the change list `hasChanges()`. (An empty sync directory reports no
  drift.)
- **Message** — `getDefaultMessage()` builds the body: optional host label, the line
  "There are configuration changes not exported on the site.", and, when `list_changes` is on,
  the newline-joined changed object names from `getChanges()` (respecting `list_changes_limit`).
  The Slack variant is the same text with markdown wrapping.
- **Delivery** — email goes through `hook_mail` key `config_notify`; Slack goes through
  `slack.slack_service`. See [../api/notifier.md](../api/notifier.md) and
  [../hooks/cron.md](../hooks/cron.md).

Note: `list_changes` reports only the **names** of changed config objects (e.g.
`system.site`, `views.view.frontpage`), never the changed values.
