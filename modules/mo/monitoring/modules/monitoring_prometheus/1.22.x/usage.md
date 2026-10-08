Monitoring Prometheus exposes every Monitoring sensor's result at a `/metrics` endpoint in Prometheus text-exposition format, so a Prometheus server can scrape Drupal site-health metrics.

---

The submodule adds a single route, `monitoring_prometheus.metrics` at path `/metrics` (registered dynamically via `Routes::routes()` so it can attach all enabled authentication providers). `MetricsController::metrics()` runs the sensors and serialises their results with a Prometheus serializer service (`monitoring_prometheus.serializer`, built from `PNX\Prometheus`), attaching any configured custom labels. Access is controlled two ways: the `access monitoring prometheus metrics` permission, and an IP allowlist checked by `MetricsController::ipAccess()` — if `monitoring_prometheus.settings:allowed_ips` is non-empty, only those client IPs may scrape; if empty, any IP passes the IP check (permission still applies). Configuration lives in `monitoring_prometheus.settings` with two sequence keys: `allowed_ips` (restrict scrapers) and `custom_labels` (labels added to exported metrics). There is no admin form shipped for these keys — set them via config (`drush cset`/config import). Depends on the base `monitoring` module.

---

- Scrape Drupal site-health sensors into Prometheus from `/metrics`.
- Feed Monitoring sensor results into Grafana dashboards via Prometheus.
- Alert in Alertmanager on a sensor crossing its warning/critical threshold.
- Restrict who can read `/metrics` to your Prometheus server's IP with `allowed_ips`.
- Add environment/cluster `custom_labels` to every exported metric.
- Expose cron-age, watchdog-error, and disk-usage sensors as Prometheus gauges.
- Integrate Drupal health into an existing Prometheus/Grafana observability stack.
- Combine with authentication providers (basic auth, etc.) for secured scraping.
- Export numeric sensor values (time_interval, number) as scrapeable metrics.
- Track sensor status over time in Prometheus time-series.
- Gate access behind the `access monitoring prometheus metrics` permission for a scraper role.
- Provide a machine-readable metrics endpoint separate from the human `/admin/reports/monitoring` UI.
- Monitor multiple Drupal sites centrally by scraping each site's `/metrics`.
- Add per-site labels so metrics from many sites are distinguishable in Prometheus.
- Trigger PagerDuty/Opsgenie via Alertmanager on critical Drupal sensor states.
- Allowlist several Prometheus replicas' IPs for high-availability scraping.
- Replace ad-hoc Nagios checks with Prometheus scraping of the same sensors.
- Export search-index, queue-size, and opcache sensors as metrics for capacity planning.
- Keep the endpoint open (empty `allowed_ips`) inside a trusted network, secured by permission only.
- Verify a deployment's health by scraping `/metrics` right after release.
