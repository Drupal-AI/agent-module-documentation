# Configure Monolog — channels, handlers, formatters, processors

Monolog has **no admin UI and no config entities**. Everything is done in a services YAML file
plus parameters. Create `sites/default/monolog.services.yml` and register it in `settings.php`:

```php
$settings['container_yamls'][] = 'sites/default/monolog.services.yml';
```

Then rebuild the container (`drush cr`) after any change.

## Parameters

| Parameter | Purpose |
|---|---|
| `monolog.channel_handlers` | Map each log channel to one or more handlers. A `default` key is the required fallback. |
| `monolog.processors` | Default processor list applied to handlers that don't specify their own. |
| `monolog.logger.processors` | Processors pushed onto the whole logger instance (all channels). |

Module defaults (`monolog.services.yml`): `default: ['syslog']`, `php: ['error_log']`, and
`monolog.processors: ['message_placeholder','current_user','request_uri','ip','referer','filter_backtrace']`.

## Handlers

A handler is a service named `monolog.handler.<name>` whose class is any Monolog handler.
Reference it in `channel_handlers` by the `<name>` part only.

```yaml
parameters:
  monolog.channel_handlers:
    php: ['rotating_file_php']   # the php channel → its own file
    default: ['rotating_file']   # everything else → shared file
services:
  monolog.handler.rotating_file:
    class: Monolog\Handler\RotatingFileHandler
    arguments: ['private://logs/debug.log', 10, 'DEBUG']   # path, maxFiles, min level
    shared: false
  monolog.handler.rotating_file_php:
    class: Monolog\Handler\RotatingFileHandler
    arguments: ['private://logs/php.log', 10, 'DEBUG']
    shared: false
```

Handlers pre-defined by the module (all `shared: false`): `browser_console`, `chrome_php`,
`fire_php`, `error_log` (ErrorLogHandler), `syslog` (SyslogHandler, arg `'drupal'`), `null`
(NullHandler). Any other Monolog handler class works — just declare a service for it, e.g.
`Monolog\Handler\StreamHandler` (`php://stdout`), `SlackHandler`, `FingersCrossedHandler`, and
the Drupal-aware `Drupal\monolog\Logger\Handler\DrupalMailHandler` (`arguments: ['to@example.com','DEBUG']`).

## Simple vs nested syntax

Simple = list of handler names. Nested = per-handler `formatter` + `processors`:

```yaml
parameters:
  monolog.channel_handlers:
    php:
      handlers:
        - name: 'rotating_file'
          formatter: 'json'
          processors: ['current_user']
        - name: 'drupal.dblog'
          formatter: 'line'
    default:
      handlers:
        - name: 'syslog'
```

If no formatter is given, the handler falls back to the line formatter. A single handler
instance is reused across channels when its configuration (name+formatter+processors) is identical.

## Formatters

Services `monolog.formatter.<name>`, referenced by `<name>`. Provided: `line`, `json`, `html`,
`normalizer`, `scalar`, `chrome_php`, `fluentd`, `loggly`, `mongodb`, `wildfire`, `gcp`
(GoogleCloudLogging), `drush` (DrushLineFormatter — use for stdout/stderr under Drush Batch),
and `drush_or_json` (a ConditionalFormatter picking drush vs json via the cli resolver).
`gelf` is registered only if the `gelf` package is installed.

## Processors

Services `monolog.processor.<name>`. Drupal-provided: `message_placeholder` (interpolates
Drupal placeholders — omit it for `drupal.dblog` to match core behavior), `current_user`,
`request_uri`, `server_host`, `referer`, `ip`, `filter_backtrace` (ContextKeyFilter dropping
`backtrace`), `introspection`. Monolog built-ins: `git`, `memory_usage`, `memory_peak_usage`,
`process_id`, `psr_log_message`, `tag`, `uid`, `web`. Scope options:

```yaml
parameters:
  monolog.processors: ['message_placeholder', 'current_user']   # per-handler default
  monolog.logger.processors: ['debug']                          # whole logger (all channels)
```

## Conditional (web vs CLI)

`ConditionalHandler`/`ConditionalFormatter` take two targets + a condition resolver service.
`monolog.condition_resolver.cli` returns true under CLI; `monolog.condition_resolver.on_gcp`
reads the `MONOLOG_ON_GCP` env var. Useful to log to stdout on the web but to Drush on CLI so
Drush's JSON output isn't corrupted.
