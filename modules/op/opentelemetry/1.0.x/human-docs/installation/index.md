# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).
- A number of **OpenTelemetry PHP libraries**, pulled in automatically by
  Composer:
  - `open-telemetry/sdk`
  - `open-telemetry/exporter-otlp`
  - `open-telemetry/opentelemetry-propagation-traceresponse`
  - `open-telemetry/sem-conv`
  - `google/protobuf`
  - a PSR HTTP client implementation (`psr/http-client-implementation`)
- **Optional:** `open-telemetry/transport-grpc` if you want to use the `grpc`
  protocol. Without it, the module gracefully falls back to `http/json`.
- An **OpenTelemetry collector or OTLP‑compatible APM backend** to receive the
  data (not a code dependency, but the module has nowhere to export to without
  one).

## Install with Composer

From the project root:

```bash
composer require drupal/opentelemetry -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
OpenTelemetry libraries and update any shared dependencies as needed. Because
this module brings in several third‑party packages, always install it through
Composer rather than downloading it manually.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/opentelemetry -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opentelemetry -y
```

Then configure the collector endpoint and service name before you expect data to
flow — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

The base module handles **traces**. Three optional submodules reuse the same
transport and configuration plumbing to add more signals:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OpenTelemetry Logs** | `opentelemetry_logs` | A logger that pushes Drupal log records over OTLP to a logs receiver. |
| **OpenTelemetry Syslog** | `opentelemetry_syslog` | Swaps core's syslog logger to inject the current trace ID into syslog lines, so log lines correlate with traces. |
| **OpenTelemetry Metrics** | `opentelemetry_metrics` | An API for emitting custom application metrics (counters, histograms). |

Enable whichever you need, for example:

```bash
drush en opentelemetry_logs -y
```

Each submodule requires the base OpenTelemetry module, which is already present
once you have installed it above.
