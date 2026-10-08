# Monitoring Mail — configuration & trigger

## Settings — `monitoring_mail.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `mail` | email | `''` | recipient address for escalation mail (empty = disabled) |
| `severities` | sequence of strings | `[CRITICAL]` | statuses whose transitions trigger mail (e.g. `CRITICAL`, `WARNING`) |

Set via config (no dedicated form — see below):

```bash
drush cget monitoring_mail.settings
drush cset monitoring_mail.settings mail ops@example.com
drush cset monitoring_mail.settings severities.0 CRITICAL
drush cset monitoring_mail.settings severities.1 WARNING
```

## Where it is edited in the UI

`monitoring_mail_form_monitoring_settings_alter()` adds the recipient + severities fields to the **base**
Monitoring settings form at `/admin/config/system/monitoring/settings`; the matching submit handler saves
them into `monitoring_mail.settings`.

## How mail is triggered

- `monitoring_mail_monitoring_run_sensors(array $results)` (implements `hook_monitoring_run_sensors`)
  runs after each sensor run.
- For each result, `monitoring_mail_needs_mail($result, $severities, $status_old, $status_new)` returns
  TRUE when the sensor **transitions** into one of the configured severities.
- `monitoring_mail_mail()` (`hook_mail`) builds the message; core mail delivers it to `mail`.

So mail is sent on a **status change** into a configured severity, not repeatedly for a steady bad state.
