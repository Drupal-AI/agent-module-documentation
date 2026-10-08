<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Reverse Proxy Header

There is **no admin UI and no Drupal config**. All configuration is `$settings` in
`settings.php` (or an included settings file). After editing, the change takes effect on the
next request — no cache rebuild needed to read `Settings`, though `drush cr` is harmless.

## Settings keys

| `$settings` key | Type | Default | Effect |
|---|---|---|---|
| `reverse_proxy_header` | string | *(unset)* | The `$_SERVER` header key that carries the real client IP, e.g. `'HTTP_X_FORWARDED_FOR_CUSTOM_HEADER'`. **If unset, the module does nothing.** |
| `reverse_proxy_header_trusted_addresses_ignore` | bool | `FALSE` | When `TRUE`, always use the header value regardless of trusted-proxy checks (convenient but allows IP spoofing). |

Minimal config:

```php
$settings['reverse_proxy_header'] = 'HTTP_X_FORWARDED_FOR_CUSTOM_HEADER';
```

## How the client IP is chosen (`ReverseProxyHeaderClientIpRestore::onRequest`)

1. Read `$settings['reverse_proxy_header']`. If empty → return (no-op).
2. **Trusted-proxy gate.** If ALL of these are true, skip processing (header only trusted
   from trusted proxies):
   - `$settings['reverse_proxy'] === TRUE` (core setting), and
   - `$settings['reverse_proxy_addresses']` is set (core setting), and
   - `$settings['reverse_proxy_header_trusted_addresses_ignore'] !== TRUE`, and
   - the request is **not** from a trusted proxy (`$request->isFromTrustedProxy() === FALSE`).
3. Read the header value from `$_SERVER`; if empty → return.
4. `explode(',', ...)` + `trim`, then take the **first** value passing
   `filter_var($ip, FILTER_VALIDATE_IP)`.
5. Set `HTTPS` on/off from `$request->isSecure()`, set `REMOTE_ADDR` to that IP, and call
   `$request->overrideGlobals()`.
6. If no valid IP is found, log a notice to the `reverse_proxy_header` channel.

## Interaction with core reverse-proxy settings

- To restrict trust to your load balancers, set the core settings and leave
  `reverse_proxy_header_trusted_addresses_ignore` at its default `FALSE`:
  ```php
  $settings['reverse_proxy'] = TRUE;
  $settings['reverse_proxy_addresses'] = ['10.0.0.5', '10.0.0.6'];
  $settings['reverse_proxy_header'] = 'HTTP_X_MY_REAL_IP';
  ```
- To always trust the header (e.g. local testing, or a fully controlled network) even without
  trusted-proxy addresses:
  ```php
  $settings['reverse_proxy_header'] = 'HTTP_X_MY_REAL_IP';
  $settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE;
  ```

## Priority

The subscriber runs on `KernelEvents::REQUEST` at priority **350**, ahead of core's
`RouterListener` and `AuthenticationSubscriber`, so downstream code (routing, auth, flood
control) sees the corrected `REMOTE_ADDR`.

## Inspecting / verifying on a live site

```bash
# What header is Drupal configured to read?
drush ev "print \Drupal\Core\Site\Settings::get('reverse_proxy_header');"
# Is the ignore-trusted-addresses flag on?
drush ev "var_export(\Drupal\Core\Site\Settings::get('reverse_proxy_header_trusted_addresses_ignore'));"
```

`Settings` is read fresh on each Drupal bootstrap, so a `drush ev` call reflects the current
`settings.php` values.
