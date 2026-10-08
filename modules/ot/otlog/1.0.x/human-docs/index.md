# OpenTelemetry Log — manual setup guide

**OpenTelemetry Log** (`otlog`) ships Drupal's log events to an **OpenTelemetry
(OTLP) log endpoint**, so your application logs can flow into the same
observability pipeline as your traces and metrics — a collector, or a backend
like Grafana Loki, Honeycomb, or any OTLP‑compatible service.

On its own the module doesn't do anything: it only produces output inside an
active OpenTelemetry context. That context is supplied by the OpenTelemetry SDK
and one of its exporter libraries, which you add via Composer and configure
through PHP settings (either zero‑code instrumentation or SDK autoloading). The
companion **OpenTelemetry SDK** module (`otsdk`) provides a straightforward way to
configure and autoload the SDK from `settings.php`.

Configuration for this module lives in code and environment (Composer libraries
and `settings.php` / environment variables), not in an admin form — so setup is a
developer/operator task rather than something you click through.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   OpenTelemetry libraries, and enable the module.

There is **no admin settings form** — the OpenTelemetry SDK is configured via
`settings.php` and environment variables, described under Installation.

## How to use it

1. Install the module and the OpenTelemetry libraries (see Installation).
2. Set up either **zero‑code instrumentation** or **SDK autoloading** and supply
   an appropriate OpenTelemetry configuration (endpoint, exporter, credentials) —
   the easiest route is to use the **OpenTelemetry SDK** module (`otsdk`) and
   configure it in `settings.php`.
3. Point your OTLP configuration at your collector or logging backend. Keep any
   endpoint credentials in environment variables rather than committing them.
4. Once a context is active, Drupal log events are exported to your OpenTelemetry
   log endpoint automatically.
