# Configuration

There is **no settings form**. Trusted Reverse Proxy is configured through
Drupal's core `Settings` (in `settings.php`) and one service parameter. Enabling
the module turns the auto-detection on; the options below let you steer or
disable it.

## When the auto-detection kicks in

On each request, the module's middleware rewrites Drupal's runtime reverse-proxy
settings **only when all** of these are true:

- You have **not** explicitly disabled it (`reverse_proxy` is not set to `FALSE`
  in `settings.php`).
- You have **not** already listed proxy addresses (`reverse_proxy_addresses` is
  empty). If you set your own list, the module steps aside and yields to it.
- The request carries an `x-forwarded-for` header.
- A `REMOTE_ADDR` is present.

When it acts, it tells Drupal, for that request only, that it is behind a reverse
proxy and builds the trusted-proxy list from the request itself: the immediate
connecting address (`REMOTE_ADDR`) plus every `x-forwarded-for` entry **except
the left-most** one — the left-most value is treated as the real client IP. This
is what lets a site sit behind a variable number of proxies without you
enumerating their addresses.

## `settings.php` options

You control the behaviour with the standard core reverse-proxy settings:

- **Disable entirely** — for a site that is *not* behind a proxy:

  ```php
  $settings['reverse_proxy'] = FALSE;
  ```

- **Pin an explicit proxy list** *(recommended in production when you know your
  proxy IPs)* — the module then does nothing and core uses your list:

  ```php
  $settings['reverse_proxy_addresses'] = ['203.0.113.5', '203.0.113.6'];
  ```

  You can also set the usual companions such as
  `$settings['reverse_proxy_trusted_headers']`.

- **Leave both unset** — this is what triggers the module's auto-detection
  described above.

## The status-report tweak

The module lowers the severity of core's "trusted host patterns not configured"
finding on **Reports → Status report** (`/admin/reports/status`). When a reverse
proxy is actually configured, it also rewrites the message to explain that the
missing pattern is "not necessarily a security risk *if* you trust your upstream
network path".

The severity is set by a service parameter, `trusted_reverse_proxy.severity`,
which defaults to `1` (warning). Values are `-1` = info, `1` = warning, `2` =
error. To restore the original error severity, override that parameter from your
own module's `services.yml` or a service provider.

## Recommended production setup

The convenience above comes from deriving the trusted proxy addresses from
`x-forwarded-for` instead of a configured list. For production, pin
`$settings['reverse_proxy_addresses']` with your actual proxy IPs (which makes
this module stand down), or set `$settings['reverse_proxy'] = FALSE;` if you are
not behind a proxy.
