# OpenTelemetry — manual setup guide

**OpenTelemetry** (`opentelemetry`) instruments your Drupal site with
[OpenTelemetry](https://opentelemetry.io), the vendor‑neutral observability
standard. It wraps every request in a root **trace span** and exports those spans
over the OTLP protocol to an OpenTelemetry collector or APM backend — Jaeger,
Grafana Tempo, Honeycomb, Elastic APM, and so on — using the official
opentelemetry‑php SDK. With submodules it can also ship logs and metrics, so you
can correlate traces, logs, and metrics for a single request across your
observability stack.

On each request the module opens a root server span named after the HTTP method
and URL, tagged with standard HTTP/URL/network attributes. It honors an incoming
W3C `traceparent` header so a request can continue a distributed trace begun
upstream (you can also choose to ignore untrusted inbound headers). What actually
gets traced is decided by a set of small **trace plugins** — bundled ones cover
the request, unhandled exceptions, and (on Drupal 10.1+) individual database
statements — which you toggle on the settings form.

To use it you point the module at your collector's **endpoint**, choose the OTLP
**protocol** (`http/protobuf`, `http/json`, or `grpc`), and optionally supply an
**Authorization header** for a secured or SaaS endpoint. A nice touch: rather
than feeding these to the SDK directly, the module translates them into the
standard `OTEL_*` environment variables — so any value you set in the real
environment or `settings.php` takes precedence, and the form shows an "overridden"
note when it does.

> **Secrets:** the Authorization header for a SaaS collector is a credential.
> Prefer setting it through the environment (`OTEL_EXPORTER_OTLP_HEADERS`) or
> `settings.php` rather than storing it in exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (this pulls in
   several OpenTelemetry PHP libraries), enable the module, and choose the
   logs/metrics/syslog submodules you need.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus the environment‑variable overrides and the trace plugins.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → OpenTelemetry**
(`/admin/config/development/opentelemetry`), behind the core **Administer site
configuration** permission.

## How to use it

1. Stand up an OpenTelemetry collector (or use a SaaS OTLP endpoint).
2. Enable the module, open the settings form, set the **endpoint**, **service
   name**, and **protocol**, and add an **Authorization** header if your endpoint
   requires one.
3. Pick which **trace plugins** to enable, save, and watch traces arrive in your
   APM backend.
