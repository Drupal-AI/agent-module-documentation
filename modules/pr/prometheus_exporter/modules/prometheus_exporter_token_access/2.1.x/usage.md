<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Prometheus Exporter that lets a static token (query string `?token=`, or `Authorization: Bearer`) grant access to `/metrics` in place of the `access prometheus metrics` permission, with per-IP flood control on failed attempts.

---

Enabling this submodule alters the `prometheus_exporter.metrics` route: a `RouteAlterSubscriber`
**replaces** the route's `_permission: access prometheus metrics` requirement with a custom access
check `_prometheus_token_access`. `TokenAccessCheck::access()` grants access if the current user holds
`access prometheus metrics` OR the request carries the configured token. The token is read from
`prometheus_exporter_token_access.settings.access_token` (set it in `settings.php` as
`$config['prometheus_exporter_token_access.settings']['access_token'] = '...';`, or via config). Failed
token attempts are flood-limited per client IP (`flood_limit` default 50, `flood_window` default 3600s).
**Important default:** the shipped `access_token` is an empty string, and when no token is configured
the check returns `AccessResult::allowed()` for everyone, so set a token when enabling it. No config UI is provided;
configure via `settings.php`/config. Depends only on `prometheus_exporter`.

---

- Let a Prometheus scraper authenticate to `/metrics` with a static token instead of a Drupal account.
- Pass the token as `?token=abcd1234` in the scrape URL.
- Pass the token as an `Authorization: Bearer abcd1234` header instead of the query string.
- Keep the token out of config export by setting it in `settings.php`.
- Flood-limit brute-force token guessing per IP.
- Tune the flood limit/window for a busy scraper.
- Still allow permission-based access in parallel (permission is checked first).
- Give an external monitoring SaaS scrape access without provisioning a user.
- Rotate the scrape token by editing `settings.php` and clearing cache.
- Combine with a firewall rule so only the monitoring host can reach `/metrics`.
- Keep permission-based access working for internal users while a token serves the scraper.
- Set a long random token to resist guessing, backed by per-IP flood control.
- Lower the `flood_limit` to clamp down on token brute-force attempts.
- Widen the `flood_window` for stricter blocking over a longer period.
- Store the token in a secrets manager and inject it into `settings.php` at deploy time.
- Provide scrape access from a managed monitoring platform (Grafana Cloud) via Bearer token.
- Audit blocked attempts through the module's flood warning log entries.
- Avoid provisioning a Drupal user/role purely for a monitoring agent.
- Explicitly set a non-empty token before enabling on production (empty token = open endpoint).
