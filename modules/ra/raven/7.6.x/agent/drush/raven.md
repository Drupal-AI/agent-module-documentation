<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raven Drush commands

Defined via PHP attributes in `src/Drush/Commands/RavenCommands.php` (no
`drush.services.yml`; the class extends `Drush\Commands\DrushCommands` and is
autodiscovered). Both commands force-build the Sentry client
(`getClient(FALSE, TRUE)`); if no DSN is configured they warn (`Sentry client key
is not configured…`) but still exercise the client, and throw on a genuinely
invalid client.

## `raven:captureMessage [message]`

Sends a test **Sentry event** (message) to verify configuration
(`\Sentry\captureMessage`).

- Argument `message` — text to send (default: `Test message from Drush.`).
- Option `--level` — `debug`, `info`, `warning`, `error`, `fatal` (default `info`;
  passed to `new \Sentry\Severity()`).
- On success prints `Message sent as event <id>.` (throws `Send failed.` if no id).

```bash
drush raven:captureMessage
drush raven:captureMessage 'Mic check.' --level=error
# Verbose Sentry SDK debug output:
drush --debug raven:captureMessage
```

## `raven:captureLog [message]`

Sends a Sentry **structured logs** item (lightweight, no stack trace). It adds the
item to `\Sentry\logger()->aggregator()` and immediately `flush()`es it, so it
delivers whenever a DSN is configured (independent of the `logs_log_levels`
setting, which only governs automatic capture of Drupal log messages).

- Argument `message` — text (default: `Test log from Drush.`).
- Option `--level` — a Sentry logs level: `trace`, `debug`, `info`, `warn`,
  `error`, `fatal` (default `info`; validated as a callable on
  `Sentry\Logs\LogLevel`).
- On success prints `Log sent as event <id>.`

```bash
drush raven:captureLog 'Mic check.' --level=error
```

## Related settings & tracing

`preCommand()` (a `@hook pre-command *`) wires Drush error handling and tracing for
**every** command:

- `drush_error_handler` — sends exceptions thrown by any Drush command to Sentry
  (`onConsoleError` → `\Sentry\captureException`).
- `drush_tracing` — wraps each command in a Sentry transaction
  (`drush <command>`), finished on `ConsoleEvents::TERMINATE` with the exit code
  tagged.

Both are keys in `raven.settings` (see [configure/raven.md](../configure/raven.md)),
not separate commands. Non-Drush Symfony Console (`dr`) commands are traced
separately via `console_tracing` (handled by
`Drupal\raven\EventSubscriber\ConsoleSubscriber`).
