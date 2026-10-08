# Trusted Reverse Proxy Support — agent index

One HTTP middleware that, when enabled and unconfigured, auto-populates Drupal's `reverse_proxy` /
`reverse_proxy_addresses` runtime settings from the incoming `x-forwarded-for` header, plus a
status-report tweak. No admin UI (`configure` null), no config entity, no permissions, no Drush.
**Opt-in; intended for sites behind upstream proxies you control.**

- **Exactly when it activates, what it sets, the settings.php overrides and the status-report
  severity parameter** → [configure/settings.md](configure/settings.md)

Key facts:
- Service `http_middleware.trusted_reverse_proxy` (`TrustedReverseProxyMiddleware`, tag priority
  301), arg `@settings`.
- Activation guard (all must hold): `reverse_proxy !== FALSE` AND
  `count(reverse_proxy_addresses) === 0` AND request has `x-forwarded-for` AND `REMOTE_ADDR` set.
  Then it re-instantiates `Settings` with `reverse_proxy = TRUE` and detected addresses.
- Detected addresses = `[REMOTE_ADDR]` plus every `x-forwarded-for` value **except the left-most**
  (the left-most is taken as the client IP). No allow-list of real proxy IPs is used.
- `trusted_reverse_proxy_preprocess_status_report_page()` downgrades the `trusted_host_patterns`
  requirement severity (service parameter `trusted_reverse_proxy.severity`, default 1 = warning).
