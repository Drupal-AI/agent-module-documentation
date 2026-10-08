# Configuration

Reverse Proxy Header has **no admin UI and no Drupal configuration entity**.
Everything is set through `$settings` in `settings.php` (or an included settings
file). Changes take effect on the next request — `Settings` is read fresh on each
bootstrap, so no cache rebuild is required (a `drush cr` is harmless if you run
one anyway).

## The two settings keys

### `reverse_proxy_header` — the header to read

```php
$settings['reverse_proxy_header'] = 'HTTP_X_FORWARDED_FOR_CUSTOM_HEADER';
```

This is the name of the `$_SERVER` key that carries the real client IP. Note the
`HTTP_` prefix and the upper‑case, underscore form that PHP uses for incoming
headers — an `X-Forwarded-For-Custom-Header` HTTP header becomes
`HTTP_X_FORWARDED_FOR_CUSTOM_HEADER` in `$_SERVER`.

**If this setting is unset, the module does nothing** — it is a complete no‑op.
This is the one line most sites need.

### `reverse_proxy_header_trusted_addresses_ignore` — bypass the trust check

```php
$settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE;
```

Defaults to `FALSE`. When `TRUE`, the module always uses the header value,
regardless of whether the request came from a trusted proxy. This is convenient
for local testing or a fully controlled network, but it **allows IP spoofing** —
any client could send a forged header — so avoid it on public sites unless you
understand the risk.

## How the client IP is chosen

On each request the module's event subscriber does the following:

1. Reads `$settings['reverse_proxy_header']`. If empty, it stops (no‑op).
2. **Trusted‑proxy gate.** If core's reverse proxy is enabled
   (`$settings['reverse_proxy'] === TRUE`), trusted addresses are configured
   (`$settings['reverse_proxy_addresses']`), the ignore flag is *not* set, and
   the request did **not** come from a trusted proxy, then the module skips
   processing — the custom header is only trusted when it arrives via one of your
   proxies.
3. Reads the header value from `$_SERVER`; if empty, stops.
4. Splits the value on commas, trims each part, and takes the **first** one that
   passes PHP's `FILTER_VALIDATE_IP` — this handles forwarding headers that carry
   a list of hops.
5. Sets `HTTPS` on/off from whether the request is secure, writes the chosen IP
   into `REMOTE_ADDR`, and refreshes PHP's superglobals.
6. If no valid IP is found, it logs a notice to the `reverse_proxy_header` log
   channel and leaves `REMOTE_ADDR` unchanged.

The subscriber runs on the kernel `REQUEST` event at priority **350**, ahead of
core's router and authentication subscribers, so routing, authentication and
flood control all see the corrected address.

## Recommended setups

**Restrict trust to your load balancers** (the safe choice for public sites) —
combine with core's reverse‑proxy settings and leave the ignore flag off:

```php
$settings['reverse_proxy'] = TRUE;
$settings['reverse_proxy_addresses'] = ['10.0.0.5', '10.0.0.6'];
$settings['reverse_proxy_header'] = 'HTTP_X_MY_REAL_IP';
```

**Always trust the header** (local testing or a fully controlled network only):

```php
$settings['reverse_proxy_header'] = 'HTTP_X_MY_REAL_IP';
$settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE;
```

## Inspecting the live values

```bash
# What header is Drupal configured to read?
drush ev "print \Drupal\Core\Site\Settings::get('reverse_proxy_header');"

# Is the ignore-trusted-addresses flag on?
drush ev "var_export(\Drupal\Core\Site\Settings::get('reverse_proxy_header_trusted_addresses_ignore'));"
```

Because settings are read on each bootstrap, these commands always reflect the
current `settings.php` values.
