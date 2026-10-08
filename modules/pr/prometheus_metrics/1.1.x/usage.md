<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prometheus Metrics provides metrics to the Prometheus monitoring service via a scrape endpoint, protected by a permission by default.

---

Prometheus Metrics exposes site/application metrics in Prometheus format via a scrape endpoint, so a
Prometheus monitoring server can collect metrics (request counts, route timings, and — via a
`prometheus_metrics_commerce` submodule — commerce metrics). Admin configuration routes are at
`/admin/config/system/prometheus` (gated by `administer site configuration`), and it provides an `access
prometheus metrics` permission.

Use it to monitor a Drupal site with Prometheus. **The metrics endpoint is secure by default**: its access
checker defaults `require_auth` to TRUE and then requires the `access prometheus metrics` permission — so an
anonymous scraper is denied unless the permission is granted (or `require_auth` is explicitly turned off).
This is the correct, safe-by-default posture (metrics aren't public unless you choose). When adopting: to
let Prometheus scrape, either grant the `access prometheus metrics` permission to the anonymous role
(preferably only from a firewalled/internal network), use basic-auth, or set `require_auth = FALSE` **only**
if the endpoint is protected at the network layer — because metrics can reveal operational detail (route
names, traffic patterns). Keep the endpoint access as tight as your monitoring setup allows.

---

- Expose metrics to Prometheus.
- Provide a scrape endpoint.
- Collect request/route metrics.
- Use the commerce metrics submodule.
- Gate admin routes by administer site configuration.
- Provide an access prometheus metrics permission.
- Default require_auth to TRUE (secure by default).
- Deny anonymous scrapers unless granted.
- Grant the permission from an internal network only.
- Set require_auth=FALSE only behind a firewall.
- Know metrics reveal operational detail.
- Keep endpoint access tight.
- Monitor with Prometheus.
- Scrape metrics securely.
- Configure the metrics endpoint.
- Use basic-auth for scraping.
- Protect the endpoint at the network layer.
- Collect commerce metrics.
- Configure metrics collection.
- Expose Prometheus metrics
