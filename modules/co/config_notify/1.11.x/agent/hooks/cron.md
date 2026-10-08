# Hooks: cron trigger and mail key

The module implements three hooks (`config_notify.module`, `config_notify.install`).

## `hook_cron` — the automatic trigger

Runs on every cron. Logic:

1. `NotifierService::checkChanges()` — if there is no drift, return (nothing sent).
2. Require `config_notify.settings:cron` to be on, otherwise return.
3. If `daily` is on and `config_notify.last_sent` state already falls on today's date
   (`date('Ymd')`), return — one notification per day.
4. If `slack` is on, send `getDefaultMessage(TRUE)` via `notifySlack()`.
5. If `email` is on, send `getDefaultMessage()` via `notifyEmail(..., email_to)`.
6. If at least one send succeeded, write `config_notify.last_sent = strtotime('now')` and log
   an info message. Failures are logged as notices ("Slack/Email message not sent.").

So cron notifications require **both** drift **and** `cron` enabled; the "Notify now" button on
the settings form ignores the `cron`/`daily` flags and sends immediately when drift exists.

## `hook_mail` — key `config_notify`

Used by `notifyEmail()`:

- `from` = `system.site` `mail`.
- `subject` = "Config notify".
- `body[]` = `$params['message']` (the built notification text).

To customize the subject/body/headers, implement `hook_mail_alter()` and match
`$message['id'] === 'config_notify_config_notify'` (module `config_notify`, key `config_notify`).

## `hook_uninstall`

Deletes the `config_notify.last_sent` state value.
