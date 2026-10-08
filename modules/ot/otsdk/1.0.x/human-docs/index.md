# OpenTelemetry SDK — manual setup guide

**OpenTelemetry SDK** (`otsdk`) integrates the **OpenTelemetry SDK** into Drupal —
the observability toolkit that produces traces, metrics, and logs and ships them
to a collector or backend. This module gives you a straightforward way to
configure and autoload the OpenTelemetry PHP SDK from Drupal's `settings.php`,
which is the foundation other OpenTelemetry integrations (such as the
**OpenTelemetry Log** module, `otlog`) build on.

> This is the *OpenTelemetry* SDK — a telemetry/observability tool. It has nothing
> to do with audio/video calling SDKs.

The module itself has no admin UI. All of its configuration lives in
`settings.php` (and typically environment variables), because the OpenTelemetry
SDK is configured in code so it can be autoloaded early in the request. To
actually send data anywhere, you also add one of the OpenTelemetry **exporter**
libraries via Composer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the SDK and
   an exporter library, and configure it in `settings.php`.

There is **no admin settings form** — configuration is done in `settings.php`,
described under Installation.

## How to use it

1. Install the module and the OpenTelemetry SDK plus an exporter library (see
   Installation).
2. Add the SDK configuration to `settings.php` under `$settings['otsdk']`. A
   minimal example that writes to the console:

   ```php
   $settings['otsdk'] = [
     Variables::OTEL_PHP_AUTOLOAD_ENABLED => TRUE,
     Variables::OTEL_METRICS_EXPORTER => 'console',
     Variables::OTEL_TRACES_EXPORTER => 'console',
     Variables::OTEL_LOGS_EXPORTER => 'console',
   ];
   ```

   Swap `console` for an OTLP exporter and point it at your collector for a real
   deployment. See the OpenTelemetry docs (General SDK Configuration, OTLP Exporter
   Configuration, PHP SDK Configuration) for the full list of supported settings.
3. Keep any endpoint credentials in environment variables rather than committing
   them to `settings.php`.
