# How the stdout logger works

The whole module is one service plus a config form. There is no plugin type, no hook, no Drush.

## The service

`log_stdout.services.yml`:

```yaml
services:
  logger.stdout:
    class: Drupal\log_stdout\Logger\Stdout
    arguments: ['@config.factory', '@logger.log_message_parser']
    tags:
      - { name: logger }
```

The `{ name: logger }` tag registers it with core's `logger.factory` **in addition to** any other
loggers (dblog, syslog). Every event dispatched through the Logging API reaches
`Stdout::log($level, $message, array $context)`.

## What `log()` does

1. **Severity gate** — returns early if `$level > severity_level` (RFC levels: smaller = more
   severe). So `severity_level` is a *minimum severity* threshold.
2. **Stream selection** — if `use_stderr === '1'` **and** `$level <= RfcLogLevel::WARNING` (0–4),
   opens `php://stderr`; otherwise `php://stdout`.
3. **Placeholder substitution** — parses `$message` placeholders with the injected
   `logger.log_message_parser`, applies them, then `strtr()`s the configured `format` template with
   the event's `$context` values (`@severity`, `@type`/channel, `@uid`, `@request_uri`, `@referer`,
   `@ip`, `@link`, `@date`, etc.). `@message` and `@link` are passed through `strip_tags()`.
4. **Write** — `fwrite($output, $entry . "\r\n")` then `fclose()`.

`$context['timestamp']`, `channel`, `uid`, `request_uri`, `referer`, `ip`, `link` are the standard
keys core puts in the logger context array.

## Consequences an agent should know

- It **adds** a log destination; it does not disable dblog. Uninstall dblog separately if you want
  DB logging off.
- Because the stream is opened and closed per event, there is no buffering concern but also no
  persistent handle.
- `use_stderr` only diverts to stderr for WARNING-and-worse; INFO/NOTICE/DEBUG always go to stdout
  regardless of `use_stderr`.
- To silence low-priority noise set `severity_level` low (e.g. 3 = Error). To capture everything set
  it to 7 (Debug).
