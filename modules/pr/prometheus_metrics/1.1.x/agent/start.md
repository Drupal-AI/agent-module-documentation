<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Metrics — agent index

Exposes site/application **metrics to Prometheus** via a scrape endpoint (request/route + commerce metrics
via `prometheus_metrics_commerce`). Admin routes gated by `administer site configuration`. Config at
`prometheus_metrics.configuration_form`; provides permissions. Version **1.1.0-rc1**. Core `^11`.

**Secure by default:** the metrics endpoint's access checker defaults `require_auth=TRUE` + requires
`access prometheus metrics` — anonymous scrapers denied unless granted (or require_auth turned off). To let
Prometheus scrape: grant the permission from an internal/firewalled network, use basic-auth, or set
`require_auth=FALSE` **only** behind network protection (metrics reveal operational detail). (Contrast
`monitoring_endpoint`, which defaulted open.)
