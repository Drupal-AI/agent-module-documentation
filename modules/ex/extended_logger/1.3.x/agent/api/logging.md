# Logging with metadata & JSONPath placeholders

You do not call the logger directly by service id — log the normal Drupal way and Extended Logger
(tagged `logger`) receives the record. What Extended Logger adds is: (1) a free-form `metadata`
context key, (2) an `exception` context key expanded to a structured array, (3) JSONPath / nested
placeholders in the message, and (4) an `ExtendedLoggerEntry` model + a pre-persist event.

## Attach structured metadata

Enable the `metadata` field (on by default) and pass a `metadata` key in the log context:

```php
\Drupal::logger('my_module')->info('Order {order_id} paid', [
  'order_id' => $order->id(),
  'metadata' => [
    'amount'   => $order->getTotal(),
    'currency' => $order->getCurrency(),
    'duration' => $timer->elapsed(),
  ],
]);
```

The whole `metadata` value is stored under a `metadata` key in the JSON entry. Any other context
key becomes a field if it is listed in `fields` (or if `fields_all` is on). The form's
"Custom fields" box just adds such keys to `fields`.

## Exceptions

Pass `exception` in context (as Drupal core does). If it is a `\Throwable`, Extended Logger stores
`{message, code, file, line, trace, previous}` (recursively for `previous`); `trace` is capped by
`backlog_items_limit`. Do not enable both `exception` and `backtrace` — they duplicate.

## Placeholders in the message

`Drupal\extended_logger\Logger\ExtendedLogMessageParser` (the parser injected into
`extended_logger.logger`) understands, in addition to Drupal `@`/`%`/`:` placeholders:

| Placeholder in message | Resolves to |
|---|---|
| `{key}` | `$context['key']` |
| `{a.b.c}` | nested `$context['a']['b']['c']` (`NestedArray`) |
| `{$.a.b}` | JSONPath query over `$context` (needs `softcreatr/jsonpath`) |

Complex values are YAML-encoded into the rendered `message`. With the `message_raw` field enabled,
the raw (un-replaced) message is kept and each placeholder value is also written into the entry at
its nested path — giving you structured fields derived from the message.

### Make placeholders work for ALL loggers — `extended_logger_fallback`

The `extended_logger_fallback` submodule (dep: `extended_logger`) overrides the core
`logger.log_message_parser` service with `ExtendedLoggerFallbackLogMessageParser`, which wraps
`ExtendedLogMessageParser`. This lets dblog, syslog and every other core logger resolve the same
`{…}` / `{$.…}` placeholders (rewriting them to Drupal `@name` style). It has no configuration.

## The entry model & extension point

`Drupal\extended_logger\ExtendedLoggerEntry` (interface `ExtendedLoggerEntryInterface`) is a thin
array wrapper: `set($key,$value)`, `get($key)`, `delete($key)`, `getData()/setData()`,
`cleanEmptyValues()`, `isEmpty()`, `__toString()` = `json_encode($data)`. Before writing, the
logger dispatches `ExtendedLoggerLogEvent` (unless `skip_event_dispatch`) so subscribers can
mutate `$event->entry` — see [../events/log-event.md](../events/log-event.md).

## Static helpers on `ExtendedLogger`

- `ExtendedLogger::getRfcLogLevelAsString(int $level): string` — RFC level int → PSR string.
- `ExtendedLogger::getJsonPathValue(array $data, string $expr)` — evaluate a JSONPath expression
  (returns a missing-library marker if `Flow\JSONPath\JSONPath` is absent).
