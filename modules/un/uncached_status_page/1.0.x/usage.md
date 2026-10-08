<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Uncached Status Page provides a minimal endpoint that always bypasses caching, so an external monitor gets a live signal that Drupal is serving requests.

---

The controller at `/uncached_status_page/status` renders a single string, `Site is Up!`. An event subscriber matches that route on the kernel response and forces `Cache-Control: no-store, no-cache, must-revalidate, max-age=0` plus `Expires: 0`, so no reverse proxy, CDN or page cache can serve a stale 200. That makes the page a reliable heartbeat: a successful response proves PHP and the Drupal bootstrap are alive, not just that a cached copy exists.

The route is gated by `access content`, which anonymous users have by default, so uptime probes need no authentication. The page deliberately exposes nothing beyond the fixed "Site is Up!" text — despite the module description mentioning "monitoring", the controller returns no system status, version, database or environment data, so there is no information disclosure. Setup is simply enabling the module and pointing your monitor at the path.

---
- Point an external uptime monitor at `/uncached_status_page/status`.
- Get a guaranteed-uncached 200 response as a liveness signal.
- Verify the Drupal bootstrap (not just a cached page) is alive.
- Configure a load balancer health check against the endpoint.
- Add a Kubernetes/Docker liveness or readiness probe URL.
- Detect PHP-FPM or bootstrap failures that a cached page would hide.
- Avoid CDN/reverse-proxy caching masking an outage.
- Provide a lightweight ping target with negligible overhead.
- Monitor availability without exposing the admin status report.
- Alert on non-200 responses from the status path.
- Use the endpoint in synthetic monitoring checks.
- Confirm a deployment is serving traffic post-release.
- Keep the check anonymous so probes need no credentials.
- Ensure `no-store`/`no-cache` headers on every hit.
- Return a stable, minimal payload for fast checks.
