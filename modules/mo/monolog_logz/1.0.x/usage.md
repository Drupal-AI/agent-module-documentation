<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monolog-Logz injects Drupal configuration for shipping logs to Logz.io through the Monolog module.

---

Monolog-Logz configures the Monolog module to ship Drupal logs to Logz.io — a hosted ELK/observability
platform — for centralized log management, search and alerting. It requires PHP 8.2 and depends on the
Monolog module; it is in the Development package.

Use it to forward Drupal logs to Logz.io. As with any external log shipping, the security-relevant points
are: store the Logz.io shipping token as a secret, and be mindful that log content (request data, errors,
potentially sensitive details) is transmitted to Logz.io — scrub or avoid logging sensitive data.
Configure the Monolog handler with the Logz.io token/endpoint.

---

- Ship Drupal logs to Logz.io.
- Configure Monolog for Logz.io.
- Centralize logs on Logz.io.
- Require PHP 8.2.
- Depend on the Monolog module.
- Store the Logz.io token as a secret.
- Mind sensitive data in logs.
- Scrub sensitive log content.
- Configure the shipping endpoint.
- Forward logs for observability.
- Search logs centrally.
- Handle credentials securely.
- Alert on log events.
- Send application logs.
- Integrate Logz.io logging.
- Transmit logs externally.
- Manage logs centrally.
- Configure log shipping.
- Aggregate Drupal logs.
- Monitor via Logz.io.
