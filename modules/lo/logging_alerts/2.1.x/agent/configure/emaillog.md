# Configure email logging and alerts (emaillog)

Settings form `Drupal\emaillog\Form\EmaillogConfigForm` (form id `email_log_config_form`) at
**`/admin/config/development/emaillog`** (route `emaillog.configuration`, permission
`administer site configuration`). Edits the `emaillog.settings` config object. This module ships **no
config schema** for that object (only errorlog does). Depends on core `user`.

## Severity → email routing (the core feature)

One text field per core severity (`RfcLogLevel::getLevels()`, 0-7). Enter an address to send that
severity's log entries there; leave blank to send nothing for that severity — this is what makes emaillog
an alerting channel (e.g. Emergency/Critical → pager address, Debug → blank).

| Config key | Severity |
|---|---|
| `emaillog_0` | Emergency |
| `emaillog_1` | Alert |
| `emaillog_2` | Critical |
| `emaillog_3` | Error |
| `emaillog_4` | Warning |
| `emaillog_5` | Notice |
| `emaillog_6` | Info |
| `emaillog_7` | Debug |

## Additional debug info (`emaillog_debug_info`)

A per-severity × per-variable checkbox table selects extra data to append to each alert email. Variables
(from `_emaillog_get_debug_info_callbacks()`): `$_SERVER`, `$_ENV`, `$_REQUEST`, `$_COOKIE`, `$_GET`,
`$_POST`, `$_SESSION`, `debug_backtrace()`. Stored as `emaillog_debug_info[<severity>][<variable_key>] = 1`.
`emaillog_backtrace_replace_args` (bool, default `TRUE`, in install config) replaces backtrace argument
*values* with a `type(size)` summary to keep emails small — turning it off can crash the site on a large
trace. Other modules can add to or rewrite this data via `hook_emaillog_debug_info_alter()` (see
[../api/loggers.md](../api/loggers.md)).

## Rate limiting (consecutive similar alerts)

Three fields cap floods of near-identical alerts, compared with PHP `similar_text()`:

| Config key | Meaning |
|---|---|
| `emaillog_max_similar_emails` | Max consecutive similar alerts to send. Blank = no limit. |
| `emaillog_max_consecutive_timespan` | Minutes within which two alerts count as "consecutive". |
| `emaillog_max_similarity_level` | 0–1 similarity threshold (1 = identical) above which the cap applies. |

Form validation: setting any one of these requires the matching others; similarity must be numeric and in
`[0,1]`. The last sent message is tracked in state `emaillog.settings.emaillog_last_message`
(`{message, time, count}`).

## Subject

`emaillog_legacy_subject` (bool): when TRUE the subject is `[<site>] <Severity>: Alert from your web site`;
when FALSE (default) the subject includes the truncated start of the log message.

## Set it with Drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('emaillog.settings');
$config->set('emaillog_0', 'oncall@example.com');   // Emergency → address
$config->set('emaillog_2', 'oncall@example.com');   // Critical  → address
$config->set('emaillog_max_similar_emails', 5);
$config->set('emaillog_max_consecutive_timespan', 5);   // minutes
$config->set('emaillog_max_similarity_level', 0.9);
$config->save();
```
```bash
ddev drush cset emaillog.settings emaillog_2 oncall@example.com -y
```

## What happens at runtime

`EmailLogger::log()` (service `logger.mylog`) runs for every logged message: if `emaillog_<level>` is empty
it returns; otherwise it applies the rate-limit check, gathers any enabled debug info, and sends via
`plugin.manager.mail`->mail('emaillog', 'alert', $to, …) from the site notification address
(`system.site.mail_notification`, falling back to `mail`, then `sendmail_from`). `emaillog_mail()` builds
the subject and renders the `emaillog` theme (`emaillog.html.twig`) as the body. Template suggestions
`emaillog__<severity>`, `emaillog__<channel>`, and `emaillog__<severity>__<channel>` allow per-type body
overrides.
