<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reverse Proxy Header lets you tell Drupal which custom HTTP header holds the real client IP address (e.g. a non-standard `HTTP_X_FORWARDED_FOR_CUSTOM_HEADER`), restoring the origin IP into `REMOTE_ADDR` early in the request. It is the supported replacement for the `reverse_proxy_header` setting that Drupal core deprecated in 8.7.

---

The module is configured entirely through `$settings` in `settings.php` — it has no UI, config, permissions or Drush. A single event subscriber, `ReverseProxyHeaderClientIpRestore`, listens on `KernelEvents::REQUEST` at priority **350** (before core's `RouterListener` and `AuthenticationSubscriber`, so authentication sees the correct IP). On each request it reads `$settings['reverse_proxy_header']`; if unset it does nothing. If set, it reads that header from `$_SERVER`, splits on commas, takes the first value that passes `filter_var(..., FILTER_VALIDATE_IP)`, and writes it into `REMOTE_ADDR` (also fixing `HTTPS` and calling `overrideGlobals()`). When Drupal core's own reverse proxy is enabled (`$settings['reverse_proxy'] = TRUE`) and trusted `reverse_proxy_addresses` are configured, the module only trusts the header from a trusted proxy — unless you set `$settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE`, which makes it always use the header value (convenient but allows IP spoofing). Invalid or empty header values are logged to the `reverse_proxy_header` logger channel and ignored. Use it when the real client IP arrives in a header you cannot rename to the core-supported `X-Forwarded-For` on the proxy or server side.

---

- Restore the real visitor IP when your CDN/load balancer forwards it in a non-standard header.
- Replace the deprecated core `reverse_proxy_header` setting (removed in Drupal 8.7) with a supported equivalent.
- Make Drupal's flood control / login throttling see the true client IP instead of the proxy's.
- Give correct client IPs to modules that ban or rate-limit by IP.
- Log accurate visitor IP addresses in dblog / syslog behind a proxy.
- Feed correct IPs to analytics or geolocation that read `REMOTE_ADDR`.
- Work with a proxy chain that writes the origin IP into a custom header you cannot change.
- Extract the first valid IP from a comma-separated forwarding header.
- Restrict header trust to configured trusted proxies (`reverse_proxy` + `reverse_proxy_addresses`).
- Deliberately trust the header from any source with `reverse_proxy_header_trusted_addresses_ignore = TRUE` (testing / controlled environments).
- Ensure authentication subscribers run with the corrected IP thanks to the priority-350 listener.
- Keep `HTTPS`/secure detection consistent after overriding the remote address.
- Support Fastly / Cloudflare / Akamai setups that use bespoke client-IP headers.
- Fix IP detection for sites migrated behind a new reverse proxy without touching the proxy config.
- Diagnose invalid forwarded IPs via the module's `reverse_proxy_header` log channel.
- Avoid patching `index.php` to copy a custom header into `$_SERVER['HTTP_X_FORWARDED_FOR']`.
- Combine with core `reverse_proxy_trusted_headers` for standard headers while handling one odd header here.
- Provide correct IPs to security modules (perimeter, honeypot, IP-based access) behind a proxy.
- Ensure Drupal's `Request::getClientIp()` returns the origin address for downstream code.
- Roll out via configuration management by shipping the `$settings` lines in `settings.php`.
