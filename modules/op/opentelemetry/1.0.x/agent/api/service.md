# The `opentelemetry` service — creating spans

Service id **`opentelemetry`** (`Drupal\opentelemetry\OpentelemetryService`,
implements `OpentelemetryServiceInterface`). It is an event subscriber on `kernel.terminate` (priority
-100) and manages the request root span.

## Lifecycle

- **Constructor** reads `opentelemetry.settings`, wires the (optionally deduplicating) logger via
  `LoggerHolder::set()`, and — unless `disable` is true — gets the tracer and calls `initRootSpan()`:
  opens a `KIND_SERVER` root span named `"$METHOD $requestUri"`, starting at `REQUEST_TIME_FLOAT`, with
  HTTP/URL/network semantic-convention attributes; continues an inbound `traceparent` unless
  `ignore_parent_span` is set.
- **`onTerminate()`** optionally logs the request, then `finalize()` ends the root span, detaches the
  root scope, and `forceFlush()`es the tracer provider. `__destruct()` finalizes as a safety net.

## Useful methods

| Method | Returns | Use |
|---|---|---|
| `getTracer()` | `?TracerInterface` | The OTel tracer; null when disabled. Build spans from it. |
| `hasTracer()` | `bool` | Whether tracing is active. |
| `isPluginEnabled(string $id)` | `?bool` | Whether an `opentelemetry_trace` plugin is on (respects `enabledByDefault`). |
| `isDebugMode()` | `bool` | Debug flag. |
| `getTraceId()` | `?string` | Current root trace id. |
| `getCurrentSpan()` | `SpanInterface` | `Span::getCurrent()`. |
| `getRootScope()` | `?ScopeInterface` | Root scope. |
| `getTraceAttributesForRequestSpan(Request)` | `array` | The HTTP/URL attribute set used for request spans. |

## Create a custom child span

```php
$otel = \Drupal::service('opentelemetry');            // or inject '@opentelemetry'
if ($otel->hasTracer()) {
  $span = $otel->getTracer()->spanBuilder('my_module.expensive_op')->startSpan();
  $scope = $span->activate();
  try {
    // ... work ...
    $span->setAttribute('items', $count);
  }
  finally {
    $span->end();
    $scope->detach();
  }
}
```

Spans you create become children of the active request span and are exported with it on terminate.
Gate expensive instrumentation behind your own `opentelemetry_trace` plugin + `isPluginEnabled()`
(see [plugins/trace.md](../plugins/trace.md)).

Note: the module's DI wires most collaborators (tracer provider, span processor/exporter, transport
factory) as services in `opentelemetry.services.yml` — you normally only touch the `opentelemetry`
service. There is **no Drush command** despite a legacy `drush.command` service tag.
