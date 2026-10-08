<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monitoring Endpoint provides a JSON API endpoint for external monitoring tools to access the status of enabled Monitoring sensors, protected by a token.

---

Monitoring Endpoint provides a JSON API endpoint (`/monitoring/status`) for external monitoring tools —
returning the status of all enabled Monitoring-module sensors (and monitored cron jobs) so an uptime/health
monitor can poll the site's health. Access is gated by a token passed as `?token=`, matched against a
configured `endpoint_key`. It requires PHP 8.1 and depends on the Monitoring module. The settings form is
correctly restricted to `administer site configuration`.

After enabling the module, set an `endpoint_key`; a missing or wrong token returns 403. Serve the endpoint
only over HTTPS and treat the token as a bearer secret.

---

- Expose Monitoring sensor status as JSON.
- Let external monitors poll site health.
- Return cron/sensor status.
- Gate access with a ?token= key.
- Require PHP 8.1.
- Depend on the Monitoring module.
- Set the endpoint_key after enabling.
- Serve the endpoint only over HTTPS.
- Treat the token as a bearer secret.
- Restrict the settings form (admin).
- Poll status from a monitor.
- Protect the status endpoint.
- Configure the endpoint key.
- Secure the monitoring endpoint.
