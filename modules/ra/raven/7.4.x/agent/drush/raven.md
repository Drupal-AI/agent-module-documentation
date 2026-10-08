# Raven Drush commands

Defined via PHP attributes in `src/Drush/Commands/RavenCommands.php` (no
`drush.services.yml`). Both commands need a configured Sentry DSN to actually
deliver; without one they warn but still exercise the client.

## `raven:captureMessage [message]`

Sends a test **Sentry event** (message) to verify configuration.

- Argument `message` — text to send (default: `Test message from Drush.`).
- Option `--level` — `debug`, `info`, `warning`, `error`, `fatal` (default `info`).
- On success prints `Message sent as event <id>.`

```bash
drush raven:captureMessage
drush raven:captureMessage 'Mic check.' --level=error
# Verbose Sentry SDK debug output:
drush --debug raven:captureMessage
```

## `raven:captureLog [message]`

Sends a Sentry **structured logs** item (lightweight, no stack trace). Requires
`enable_logs: true` in `raven.settings` to be delivered.

- Argument `message` — text (default: `Test log from Drush.`).
- Option `--level` — a Sentry logs level: `trace`, `debug`, `info`, `warn`, `error`, `fatal` (default `info`).
- On success prints `Log sent as event <id>.`

```bash
drush raven:captureLog 'Mic check.' --level=error
```

## Related settings

`drush_error_handler` sends exceptions thrown by any Drush command to Sentry, and
`drush_tracing` wraps each command in a Sentry transaction — both are keys in
`raven.settings` (see configure/raven.md), not separate commands.
