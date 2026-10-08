<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Integrates Drupal with Dynatrace APM using the OneAgent PHP extension and/or the Dynatrace metric ingest API.
- Surfaces current OneAgent trace context (trace id, span id, validity) in an admin page.
- Provides an API to post custom application metrics (gauge, count) to Dynatrace.

---

## Install & configure

- Requires PHP 8.1 and, for trace info, the Dynatrace OneAgent PHP extension installed on the server.
- Configure at `/admin/config/development/dynatrace` (route `dynatrace.settings`, permission `administer dynatrace`).
- View trace info at `/admin/config/development/dynatrace/trace-info` (same permission).

---

## Usage & behaviour

- Both routes are gated by the dedicated `administer dynatrace` permission (declared in `permissions.yml`).
- `DynatraceController::getTraceInfo()` reads from the OneAgent wrapper (`OneAgent::getInstance()`); if the extension is absent it shows a "not configured" message.
- `IngestMetric::postMetric()` POSTs metric-protocol payloads to Dynatrace via the core Guzzle `http_client` with `http_errors => TRUE`; TLS verification is left at safe defaults (no `verify=>false`).
- Metric classes (`Gauge`, `Count`, `IngestMetric`, `MetricBase`) build Dynatrace metric-ingestion-protocol strings.
- `MetricBase` validates dimension key/value types via assertions and formats keys to snake_case.
- Use it to push business/application metrics (e.g. orders placed, queue depth) to Dynatrace dashboards.
- Trace-info page is handy for correlating a Drupal request with a Dynatrace trace during debugging.
- The metric ingest endpoint/token are admin configuration; store the API token as a secret (env var / Key).
- Local OneAgent ingestion adds host context automatically, so `dt.entity.host` need not be set manually.
- No anonymous endpoints exist; all surfaces require the admin permission.
- Errors posting metrics are logged rather than surfaced to end users.
- Works only meaningfully when a Dynatrace environment/token (and ideally OneAgent) is available.
- Has test coverage under `tests/`.
- Combine with cron or event subscribers to emit metrics on domain events.
- Disabling the module removes the routes and stops metric emission.
- Review the ingest URL configuration to ensure it targets your Dynatrace tenant over HTTPS.
