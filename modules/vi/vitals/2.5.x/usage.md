Vitals exposes site health data (Drupal version, PHP version, active themes, and pending/security updates) as a JSON document at a token-protected endpoint, so external monitoring services can poll a Drupal site's status.

---

Vitals adds one read-only JSON endpoint at `/vitals/{token}` (route `vitals.content`, guarded only by the core `access content` permission plus a 128-hex-character shared token stored in Drupal `state` under `vitals.token`). The controller compares the URL token to the stored token with `hash_equals()` (timing-safe) and wraps access in the core flood service (10 attempts per IP per hour); a failed/invalid token triggers the configured unauthorized response — a 404 (default) or 403. The payload is assembled from enabled `vitals_check` plugins: `cms_version` (Drupal core version), `php_version`, `themes` (default + admin theme), and `updates` (pending and security updates, pulled from the core `update` module's `update_calculate_project_data()`). A settings form at `/admin/config/services/vitals` (route `vitals_settings`, permission `administer vitals`) lets an admin generate/rotate the token, copy it, choose the 403-vs-404 behavior, and toggle which checks appear. The token is generated on install (`hook_install`) via `bin2hex(random_bytes(64))`, and regenerating it invalidates any existing clients. The module defines a `vitals_check` plugin type (annotation `@VitalsCheck`, manager `plugin.manager.vitals_check`, alter hook `vitals_check_info`) so other modules can add their own health checks. It depends on the core `update` module and has no external library dependencies.

---

- Give an external uptime/monitoring service a single JSON URL to poll for Drupal site health.
- Detect when a site has pending security updates without logging into the admin UI.
- Report the running Drupal core version to a central dashboard across many sites.
- Report the running PHP version for fleet-wide runtime auditing.
- Surface the active default and admin themes for configuration drift detection.
- Poll a token-protected endpoint from CI/CD to gate a deploy on "no security updates pending".
- Rotate the access token when a monitoring credential is compromised.
- Choose whether unauthorized requests get a 404 (hide the endpoint's existence) or a 403.
- Rely on built-in flood control to blunt brute-force guessing of the token.
- Enable only a subset of checks (e.g. just `updates`) to minimize the exposed payload.
- Add a custom `vitals_check` plugin to expose an application-specific metric (queue depth, last cron, etc.).
- Feed the `updates` output into an alerting pipeline that pages on `NOT_SECURE`/`REVOKED`/`NOT_SUPPORTED`.
- Aggregate multiple sites' update status into one operations report.
- Verify after a deployment that the reported core version matches the expected release.
- Confirm a site is on a supported PHP version before a platform upgrade.
- Track which sites still run an admin theme scheduled for removal.
- Provide a lightweight health signal to a load balancer or status page.
- Use `hash_equals`-based token comparison to avoid timing side channels on the endpoint.
- Distribute the token to a monitoring vendor without granting any Drupal login.
- Regenerate the token from the settings form and immediately re-point clients at the new URL.
- Build a Grafana/Prometheus scraper around the endpoint's JSON output.
