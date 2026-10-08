# Configuring Trusted Reverse Proxy

There is **no settings form** — behavior is driven by core `Settings` (`settings.php`) and one
service parameter. Enabling the module is the "on" switch.

## When the middleware acts

`TrustedReverseProxyMiddleware::handle()` (priority 301) rewrites the runtime `Settings` singleton
only when **all** of these are true:

- `$settings->get('reverse_proxy') !== FALSE` — i.e. you have not explicitly disabled it.
- `count($settings->get('reverse_proxy_addresses', [])) === 0` — you have **not** already set proxy
  addresses in `settings.php`. (If you set them, the module stands down and yields to your list.)
- The request has an `x-forwarded-for` header.
- `REMOTE_ADDR` is present.

When it acts it sets, for that request:

```php
new Settings([
  'reverse_proxy' => TRUE,
  'reverse_proxy_addresses' => $this->detectReverseProxies($request),
] + $this->settings->getAll());
```

`detectReverseProxies()` returns `[REMOTE_ADDR]` plus every `x-forwarded-for` entry **except the
left-most** (the left-most is treated as the real client IP). Handles `", "` / `","` separators per
RFC 7239.

## settings.php overrides

- **Disable entirely** (site is not behind a proxy): `$settings['reverse_proxy'] = FALSE;`
- **Pin an explicit proxy list** (recommended when you know your proxy IPs): set
  `$settings['reverse_proxy_addresses'] = ['203.0.113.5', ...];` — the middleware then does nothing
  and core uses your list. You may also set `reverse_proxy_trusted_headers` etc. as usual.
- Leaving both unset is what triggers the auto-detection described above.

## Status-report severity parameter

`trusted_reverse_proxy.services.yml` defines a parameter:

```yaml
parameters:
  trusted_reverse_proxy:
    severity: 1   # REQUIREMENT_WARNING (-1 = INFO, 1 = WARNING, 2 = ERROR)
```

`trusted_reverse_proxy_preprocess_status_report_page()` uses it to lower the severity of core's
"trusted_host_patterns not configured" finding on `/admin/reports/status`, recomputes the report
counters, and — when a reverse proxy is actually configured — replaces the message with an
explanation that trusting proxies makes the missing pattern "not necessarily a security risk *if*
you trust your upstream network path". Override the parameter in a `services.yml`/service provider to
restore ERROR severity.

## Production

The auto-detection derives proxy addresses from `x-forwarded-for` rather than a configured list.
Prefer pinning `reverse_proxy_addresses` explicitly in production (the middleware then stands down).
