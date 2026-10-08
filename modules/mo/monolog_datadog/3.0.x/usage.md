<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monolog Datadog provides a Monolog handler to send Drupal logs to Datadog.

---

Monolog Datadog adds a handler to the Monolog module for shipping Drupal logs to Datadog — the
monitoring/observability platform — so application logs are collected centrally alongside metrics and
traces. It depends on the Monolog module.

Use it to forward Drupal logs to Datadog for centralized log management and alerting. The security-relevant
point is the Datadog API key/credentials used to send logs — store them as secrets, and be mindful that
log content (which can include request data, errors, and potentially sensitive details) is transmitted to
Datadog, so scrub or avoid logging sensitive data. It is a logging/integration feature; configure the
Monolog handler with the Datadog credentials.

---

- Ship Drupal logs to Datadog.
- Add a Monolog Datadog handler.
- Centralize logs in Datadog.
- Depend on the Monolog module.
- Store the Datadog API key as a secret.
- Alert on log events.
- Mind sensitive data in logs.
- Scrub sensitive log content.
- Configure the Monolog handler.
- Forward logs for observability.
- Collect logs alongside metrics.
- Handle Datadog credentials securely.
- Send application logs.
- Integrate Datadog logging.
- Manage logs centrally.
- Transmit logs externally.
- Support alerting.
- Configure log shipping.
- Aggregate Drupal logs.
- Monitor via Datadog.
