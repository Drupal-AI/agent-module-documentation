<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The logger service and Monolog pipeline

## Service

`lagoon_logs.services.yml`:

```yaml
logger.lagoon_logs:
  class: Drupal\lagoon_logs\Logger\LagoonLogsLogger
  factory: Drupal\lagoon_logs\Logger\LagoonLogsLoggerFactory::create
  tags:
    - { name: logger }
  arguments: ['@config.factory', '@logger.log_message_parser']
```

The `logger` tag registers it with Drupal's `LoggerChannelFactory`, so **every** message logged through
`\Drupal::logger($channel)` (watchdog) is also delivered to this logger — you do not call it directly.

## Factory

`LagoonLogsLoggerFactory::create()` reads `host` and `port` from `lagoon_logs.settings` and computes the
full identifier via `getHostProcessIndex()` (see `configure/settings.md`). If `disable` is truthy the
identifier is `FALSE`.

## What `LagoonLogsLogger::log()` does

1. If the full identifier is falsy (module disabled), **return immediately** — nothing is sent.
2. Create a Monolog `Logger` on the message's channel (or `LagoonLogs`).
3. Attach a `SocketHandler` for `udp://<host>:<port>` (chunk size 15000 bytes).
4. Set the formatter to `LagoonLogsFormatter` (a `LogstashFormatter`) — emits JSON with `@timestamp`,
   `@version`, `host` (the full identifier), `message`, `type`/`channel`, `level`, `monolog_level`, and
   `extra` fields (`ip`, `request_uri`, `uid`, `link`, `channel`, `application`).
5. Parse message placeholders with `logger.log_message_parser`, strip tags, and log at the Monolog level
   mapped from the RFC level (`EMERGENCY=600 … DEBUG=100`).
6. Any exception reaching the socket is caught and swallowed, so logging never breaks a request.

## No public API to call

There is nothing to invoke programmatically — the integration is entirely via the `logger` tag and
config. To change behavior, change `lagoon_logs.settings` (host/port/identifier/disable) or the
`LAGOON_PROJECT` / `LAGOON_GIT_SAFE_BRANCH` environment variables.
