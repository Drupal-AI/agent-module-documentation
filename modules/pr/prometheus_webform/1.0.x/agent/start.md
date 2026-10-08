<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Exporter - Webform (prometheus_webform) — agent index

**Registers a Prometheus `MetricsCollector` exposing per-webform submission totals as a gauge.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11 (PHP >=8.1)
- **Depends:** `prometheus_exporter:^2.0`, `webform:^6.2`
- **Plugin:** `MetricsCollector` id `webform_submissions` (`SubmissionsCollector::collectMetrics()`) → Gauge `<namespace>_total`, label `webform=<id>`, from `WebformEntityStorage::getTotalNumberOfResults()`
- **No route of its own** — metrics served via the parent Prometheus Exporter `/metrics` endpoint.

**Security:** this submodule only registers a collector; it exposes **aggregate submission counts per webform (totals, not field values)**. The `/metrics` endpoint and its access control belong to the `prometheus_exporter` module — verify that endpoint is token/permission protected so submission volumes are not readable anonymously. No routes, permissions or request handling in this module. No findings within this module's own code.
