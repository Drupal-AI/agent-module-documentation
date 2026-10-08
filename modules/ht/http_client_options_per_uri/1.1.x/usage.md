<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Client Options per URI replaces Drupal's `http_client_factory` service so that Guzzle request options (timeouts, headers, TLS, proxy, etc.) can be applied selectively to outgoing HTTP requests based on a regular-expression match against the request URI.

`HcopuClientFactory` extends core `ClientFactory` and, in `fromOptions()`, unshifts a Guzzle middleware onto the handler stack. For every outgoing request the middleware calls `requestOptionsAdjust()`, which reads `Settings::get('http_client_options_per_uri_config')` (an array of `{regexp, options}` entries), finds entries whose `regexp` matches the request URI, and `NestedArray::mergeDeep()`s the matched `options` into the request options (if several regexps match, the last one wins). The module has no UI, no routes, no permissions, and no exported configuration.

Security note (as requested): the option map lives **only** in `$settings['http_client_options_per_uri_config']` in `settings.php`. Since Guzzle options are merged verbatim, an operator *can* set `verify => false` to disable TLS certificate verification for chosen hosts — a real man-in-the-middle risk for those outgoing connections. However, this is gated behind write access to `settings.php` (already root/deploy-equivalent trust); the settings are not exposed to any admin UI, config entity, or non-privileged user, so there is no web-facing exposure and no way for a site admin (let alone anonymous) to change it through Drupal. Treat any `verify => false` entry as an intentional, auditable operator choice.
---
Config source is `settings.php` only — no UI, routes, permissions, or config entities. Options are merged verbatim, so `verify => false` (disable TLS) *is* possible per host but only via settings.php (trusted operator). Overlapping regexps: the last match wins. Replaces the core `http_client_factory` service.
---
- Set a short timeout for a slow third-party API without affecting others.
- Give a specific webservice a longer `connect_timeout` than the site default.
- Apply a custom `User-Agent` header only to requests to one host.
- Route requests to one host through a specific proxy.
- Add default query or auth headers for a single external endpoint.
- Tune retry-related Guzzle options per remote service.
- Lower timeouts to PayPal while keeping higher ones for a slow CRM.
- Match hosts with a case-insensitive regexp (e.g. sandbox vs prod PayPal).
- Layer multiple option sets, relying on last-match-wins ordering.
- Keep per-service HTTP tuning in `settings.php` alongside other overrides.
- Avoid global `$settings['http_client_config']` changes that hit every request.
- Apply stricter TLS/cert options to a sensitive endpoint.
- (Operator, audited) disable TLS verification for a self-signed internal host.
- Set `allow_redirects` behaviour for one integration only.
- Attach `cert`/`ssl_key` client-certificate options for a mutual-TLS partner.
- Cap request `timeout` for health-check style calls to a flaky host.
- Debug an integration by scoping verbose Guzzle options to its URI.
- Keep the middleware active with zero code changes in calling modules.
