<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monolog Loki — agent index

Sends **Drupal logs to Grafana Loki** via Monolog (centralized log aggregation). Depends on `monolog`. Version
**1.1.0**. Core `^10||^11`.

Operations/logging — **logs can contain sensitive data** sent to an **external** endpoint: use TLS/HTTPS + auth,
store Loki **credentials** as secrets, mind log hygiene. No access role.
