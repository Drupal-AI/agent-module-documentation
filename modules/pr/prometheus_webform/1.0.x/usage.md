<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prometheus Exporter - Webform is an add-on for the Prometheus Exporter module that publishes Webform submission counts as Prometheus metrics so you can graph and alert on form activity.

It provides a single `MetricsCollector` plugin, `webform_submissions`, whose `collectMetrics()` builds a Prometheus `Gauge` named `<namespace>_total` and sets one value per webform, labelled `webform="<webform_id>"`, from `WebformEntityStorage::getTotalNumberOfResults()`. The metric is surfaced through the parent Prometheus Exporter module's `/metrics` endpoint — this submodule adds no route of its own. Requires `prometheus_exporter:^2.0` and `webform:^6.2`.

Security/operational notes: the exporter's `/metrics` endpoint and its access control are owned by the `prometheus_exporter` module, not this one — this add-on only registers a collector. The exposed data is aggregate submission counts per webform (totals only, not submission field values), but treat those counts as sensitive-ish operational data and ensure the parent `/metrics` route is protected (its token/permission) so submission volumes are not exposed anonymously. Enable/disable this collector on the Prometheus Exporter settings form like any other collector.
---
Expose per-webform submission totals as a Prometheus gauge via the Prometheus Exporter endpoint.
---
- Scrape per-webform submission totals from Prometheus.
- Add the `webform_submissions` collector to Prometheus Exporter.
- Graph form submission volume over time in Grafana.
- Alert when a webform's submission rate spikes or drops.
- Get one gauge series per webform via the `webform` label.
- Read the `<namespace>_total` gauge for aggregate counts.
- Enable the collector on the Prometheus Exporter settings form.
- Ensure the parent `/metrics` endpoint is protected (token/permission).
- Rely on `getTotalNumberOfResults()` for accurate counts.
- Monitor spam/bot submission surges by watching the gauge.
- Correlate submission counts with campaign timing.
- Compare submission volume across multiple webforms.
- Require `prometheus_exporter ^2.0` and `webform ^6.2`.
- Keep the collector disabled if submission volumes are sensitive.
- Add this metric to an existing Prometheus scrape config.
- Track submission totals without querying the database directly.
