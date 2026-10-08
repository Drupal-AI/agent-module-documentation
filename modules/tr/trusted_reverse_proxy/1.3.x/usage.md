For sites running behind trusted reverse proxies, auto-detects the proxy chain from the `x-forwarded-for` header and configures Drupal's `reverse_proxy` settings at runtime, so you don't have to hardcode proxy IPs in `settings.php`.

---

A small "sensible cloud-native defaults" module built around one HTTP middleware
(`TrustedReverseProxyMiddleware`, priority 301). On each request, **if** `reverse_proxy` is not
explicitly set to `FALSE`, **and** no `reverse_proxy_addresses` are configured, **and** the request
carries an `x-forwarded-for` header, **and** `REMOTE_ADDR` is known, it rewrites the runtime
`Settings` singleton to `reverse_proxy = TRUE` with `reverse_proxy_addresses` derived from the
request: it always trusts the immediate `REMOTE_ADDR` (first hop) and additionally trusts every
`x-forwarded-for` entry *except the left-most* (which it treats as the real client IP). This lets a
site sit behind a variable number of proxies (e.g. Cloudflare → TLS terminator → Varnish) without
enumerating their IPs. The module also softens the status-report requirement for a missing
`trusted_host_patterns` setting: a `hook_preprocess_status_report_page` downgrades that error to a
warning (severity configurable via the `trusted_reverse_proxy` service parameter) and, when a
reverse proxy is actually configured, rewrites the message to explain the trade-off. There is no
admin UI, no config, no permissions, and no Drush — installation is the configuration. It is
explicitly opt-in and intended for sites behind upstream proxies you control.

---

- Trust Cloudflare/Varnish/Traefik proxy chains for client-IP resolution without listing proxy IPs.
- Get correct client IPs in logs, flood control, and geolocation when Drupal sits behind proxies.
- Run the same codebase across local (no proxy) and production (multiple proxies) without settings changes.
- Auto-detect a dynamic/rotating set of upstream proxy addresses on cloud platforms.
- Support containerized/PaaS deployments where proxy IPs are not known ahead of time.
- Demote the "trusted host patterns not set" status-report error to a warning on proxied sites.
- Provide a collection point for cloud-native reverse-proxy best-practice defaults.
- Ensure `X-Forwarded-Proto`/HTTPS detection works correctly behind a TLS-terminating proxy.
- Resolve the true visitor IP for rate limiting and abuse detection behind a CDN.
- Populate accurate client IPs for analytics and audit modules behind proxies.
- Avoid hand-maintaining `reverse_proxy_addresses` as infrastructure changes.
- Adopt sensible reverse-proxy trust on ephemeral preview/review environments.
- Keep IP-based logic working when adding or removing a proxy hop.
- Standardize proxy trust behavior across many sites/multisite behind the same edge.
- Disable per-site by setting `$settings['reverse_proxy'] = FALSE;` when a site is not proxied.
