# Recording custom metrics

Service id **`opentelemetry.metrics`** (`Drupal\opentelemetry_metrics\OpentelemetryMetrics`).

## Get a meter and an instrument

```php
$meter = \Drupal::service('opentelemetry.metrics')->getMeter('my_module');

// Counter
$counter = $meter->createCounter('my_module.orders', 'orders', 'Orders placed');
$counter->add(1, ['channel' => 'web']);

// Histogram
$hist = $meter->createHistogram('my_module.search_ms', 'ms', 'Search latency');
$hist->record($elapsedMs, ['index' => 'content']);

// Observable gauge (callback polled at collection time)
$meter->createObservableGauge('my_module.queue_depth')
  ->observe(fn ($observer) => $observer->observe($queue->numberOfItems()));
```

`getMeter($name)` returns an OTel `MeterInterface` from the module's internal `MeterProvider`. Use any
standard OpenTelemetry instrument (counter, up-down counter, histogram, observable gauge/counter).

## Export lifecycle

- The service subscribes to `kernel.terminate` (-100) and calls `metricReader->shutdown()` there,
  flushing metrics through the OTLP `MetricExporter` at request end.
- Endpoint/protocol/auth are inherited from the parent module's transport factory (data type
  `METRICS`); set them on `opentelemetry.settings` or via `OTEL_EXPORTER_OTLP_METRICS_*` env vars
  (see the parent [configure/settings.md](../../../../../1.0.x/agent/configure/settings.md)).
- Resource attributes come from `ResourceInfoFactory::defaultResource()` (service name etc. from the
  parent config/env).

There is no settings form or Drush command; this submodule is purely a code API.
