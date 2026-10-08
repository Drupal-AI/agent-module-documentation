# Configuration

Error Log has no page of its own. It adds an **Error Log** section to core's
**Logging and errors** form at **Configuration → Development → Logging and errors**
(`/admin/config/development/logging`), which requires the **Administer site
configuration** permission. Everything is stored in the `error_log.settings`
config object.

## Log levels (severities)

A set of eight checkboxes, one per RFC 5424 severity from **Emergency** down to
**Debug** (`log_levels`). All are **on by default**. Untick a severity to stop
those messages from reaching the error log — a common production choice is to turn
off **Debug** and **Info** to cut noise while keeping warnings and errors.

```bash
# Stop logging debug and info:
drush config:set error_log.settings log_levels.level_7 false -y   # Debug
drush config:set error_log.settings log_levels.level_6 false -y   # Info
```

## Ignored channels

A textarea (`ignored_channels`), one channel per line, listing log channels to
drop entirely. It's empty by default. Use it to suppress specific noise without
turning off logging as a whole. The two most common entries are:

- `page not found` — silences 404 spam.
- `access denied` — silences 403 noise.

You can also ignore a chatty custom module by adding its channel name.

```bash
drush config:set error_log.settings ignored_channels '["page not found","access denied"]' -y
```

## Format

A single line template (`format`, up to 280 characters) built from `!`‑placeholders.
The default is:

```
[!level] [!type] [!ip] [uid:!uid] [!request_uri] [!referer] !message
```

Available placeholders:

| Placeholder | Meaning |
|-------------|---------|
| `!level` | Severity as a word (`emergency` … `debug`). |
| `!severity` | Severity as an integer 0–7 (RFC 5424). |
| `!type` | The log channel (e.g. `php`, `cron`, `system`). |
| `!message` | The message text, with its own placeholders already filled in. |
| `!ip` | Client IP of the triggering request. |
| `!uid` | User ID. |
| `!request_uri` | The requested URI. |
| `!referer` | HTTP referer, if any. |
| `!base_url` | The site's base URL (handy for distinguishing multisite logs). |
| `!link` | The operation link associated with the message, if any. |
| `!timestamp` | Unix timestamp of the event. |

```bash
drush config:set error_log.settings format '[!severity] !type: !message (uid:!uid ip:!ip)' -y
```

## Why a message might not appear

The logger drops an event in three situations:

1. Its **severity is unticked** in *Log levels*.
2. Its **channel is listed** in *Ignored channels*.
3. It's running **under Drush and PHP's `error_log` ini directive is empty** —
   because Drush already logs to the console. Set that ini directive to force CLI
   logging.

## Where the lines are written

The destination is wherever PHP's own `error_log` ini directive points — the
Apache/nginx error log, stderr, or syslog. That is a PHP setting, **not**
configurable from within Drupal.
