# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenTelemetry SDK** PHP library (required).
- At least one **exporter** library — required to ship instrumentation results to
  an OpenTelemetry endpoint. Consult the OpenTelemetry Registry for available
  exporters.

## Install with Composer

From the project root:

```bash
composer require drupal/otsdk -W
```

Then add the OpenTelemetry SDK and an exporter library that matches your backend,
for example:

```bash
composer require open-telemetry/sdk -W
# plus an OTLP exporter package appropriate to your collector/backend
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve shared
dependencies. See the OpenTelemetry PHP documentation for the exact package names.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/otsdk -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en otsdk -y
```

## Configure it in settings.php

Add an `$settings['otsdk']` array to `settings.php` supplying the OpenTelemetry SDK
configuration (autoload flag and the exporters for metrics, traces, and logs). See
the [overview](../index.md#how-to-use-it) for a minimal example. Keep endpoint
credentials in environment variables rather than committing them.

## Verify it worked

With the SDK, an exporter, and a valid `$settings['otsdk']` configuration in
place, exercise the site and confirm telemetry reaches your chosen destination —
for a quick smoke test, set the exporters to `console` and check that spans/metrics
appear, then switch to your real OTLP endpoint.
