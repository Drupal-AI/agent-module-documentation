# API — the logger factory & routing back to Drupal

## It replaces `logger.factory`

`Drupal\monolog\MonologServiceProvider::alter()` swaps the core `logger.factory` service class
for `Drupal\monolog\Logger\MonologLoggerChannelFactory`. There is **nothing new to call**: keep
using the standard channel API and it goes through Monolog.

```php
\Drupal::logger('my_module')->error('Something broke: @id', ['@id' => $id]);
// or inject the logger.factory / a logger.channel.* service as usual.
```

`MonologLoggerChannelFactory::get($channel)` builds a `Drupal\monolog\Logger\Logger` (extends
`Monolog\Logger`), attaches the handlers configured for that channel (falling back to `default`),
sets each handler's formatter/processors, and wraps it in a `LoggerInterfacesAdapter`. If the
channel resolves to no handlers it returns a `NullLogger`. `addLogger()` is a **no-op** — you do
not register loggers in code; handlers are services (see configure doc).

## How it augments / replaces dblog

Monolog takes over logging entirely, so core Database Logging (`dblog`) is bypassed unless you
opt back in. During container alter, the factory auto-registers a `DrupalHandler` wrapper for
**every service tagged `logger`**, named `monolog.handler.drupal.<id-without-logger-prefix>`.
So `logger.dblog` becomes the handler **`drupal.dblog`**. To keep writing to the Watchdog table:

```yaml
parameters:
  monolog.channel_handlers:
    default:
      handlers:
        - name: 'drupal.dblog'
          processors: ['current_user','request_uri','ip','referer','filter_backtrace','introspection']
```

Omit `message_placeholder` for `drupal.dblog` so messages match core's stored (untokenized) form.
`DrupalHandler` (`Monolog\Handler\AbstractProcessingHandler`) converts the Monolog level to an
RFC 5424 level and forwards `message` + a Drupal-shaped `context` (uid, channel, request_uri,
referer, ip, timestamp) to the wrapped Drupal logger.

## Notable services

- `logger.factory` (overridden) → `MonologLoggerChannelFactory`.
- `monolog.handler.*` — handler instances (mostly `shared: false`, one per unique config).
- `monolog.formatter.*`, `monolog.processor.*`, `monolog.condition_resolver.{cli,on_gcp}`.
- `monolog.handler.drupal.<name>` — auto-generated `DrupalHandler` for each `logger`-tagged service.

The extended `Logger` also implements Symfony's `DebugLoggerInterface`/`ResetInterface`, exposing
`getLogs()`, `countErrors()`, `clear()` for the web debug toolbar when a debug processor/handler
is present. The module requires the `monolog/monolog` (^3.2) Composer library; if the
`Monolog\Logger` class is missing, install fails via `hook_requirements()`.
