<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monolog Loki sends Drupal logs to Grafana Loki.

---

Monolog Loki **sends Drupal logs to Grafana Loki** — a log-aggregation backend — via the Monolog module,
so logs can be centralized/queried in Loki. It depends on the Monolog module, in the Development package.

Use it to ship logs to Loki. It is an operations/logging integration. Security/data handling: **logs can
contain sensitive data** (user identifiers, request detail, occasionally secrets if code logs them), and this
sends them to an **external Loki endpoint** — so use an authenticated, **TLS (HTTPS)** Loki endpoint, store any
Loki **credentials** as secrets, and mind log hygiene (avoid logging secrets/PII). It has no access-control
role. Configure the Loki endpoint and credentials.

---

- Send Drupal logs to Grafana Loki.
- Centralize logs for querying.
- Ship logs via Monolog.
- Depend on the Monolog module.
- Aggregate logs externally.
- Serve operations.
- KNOW logs can contain sensitive data.
- Use a TLS (HTTPS) Loki endpoint.
- Store Loki credentials as secrets.
- Mind log hygiene (no secrets/PII).
- Have no access-control role.
- Configure the Loki endpoint.
- Handle log shipping.
- Send logs.
- Configure Loki.
- Ship logs.
- Handle the integration.
- Aggregate logs.
- Secure the endpoint.
- Provide Loki logging.
