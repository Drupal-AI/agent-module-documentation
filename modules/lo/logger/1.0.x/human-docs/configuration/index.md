# Configuration

Logger works as soon as it is enabled, writing to a temporary JSON‑lines file. The
settings page is where you point it at a *real* destination and decide how much
structure to keep. For any environment beyond a quick local trial, changing the
target is the one setting you should not skip.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Logger**, or navigate directly to
   `/admin/config/development/logger`.

## Choose the log target

The most important choice on this page is the **output target** — where log
records are written. The available targets include:

- **File** — the default is `temporary://drupal-log.jsonl`. Convenient because it
  works everywhere, but not ideal for production performance, and you should keep
  any log file **outside the web root** so it is never web‑servable.
- **stdout / stderr** — the **recommended production choice**. Writing to stderr
  lets your container platform or a log scraper (Grafana Loki, Fluentd, the ELK
  stack, OpenTelemetry, Promtail, Splunk, Datadog, Graylog, and similar) capture
  and parse the structured output.
- **syslog** — routes entries to the system logger.
- **database** — best for local and testing environments. For a full admin UI
  over database logs, add the **Logger DB** module, which extends Logger
  automatically.
- **HTTP and cloud targets** — for shipping logs to an external endpoint. The
  target system is plugin‑based, so additional destinations can be added by
  modules.

## Tune what gets stored

Beyond the destination, the form lets you control the shape of each record so you
store only what you need:

- Emit logs as **JSON**, including only the fields you care about rather than every
  default field.
- Attach and keep **custom metadata** — the nested structure your code passes under
  `$context['metadata']` is preserved as nested JSON.
- Optionally store the **raw message with unreplaced placeholders**, keeping the
  placeholder values in separate JSON fields for cleaner machine parsing.

## Save

Click **Save configuration**. The new target and options take effect for
subsequent log writes.

## Switching target per environment (optional)

You don't have to set the target through the UI on every environment. Because the
setting lives in configuration, you can override it in `settings.php` so, for
example, production logs to stderr while local development logs to the database:

```php
if (getenv('SITE_ENV') !== 'production') {
  $config['logger.settings']['targets'][0]['plugin'] = 'database';
  $config['logger.settings']['targets'][0]['configuration'] = '{}';
}
```

This keeps a single exported configuration while letting each environment choose
its own destination.

## Remember: no secrets in logs

Whatever target you pick, be mindful that log entries and their metadata can carry
sensitive detail. Avoid logging secrets or personal data.
