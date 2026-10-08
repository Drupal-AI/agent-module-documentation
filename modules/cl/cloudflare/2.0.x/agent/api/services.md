<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare services & middleware

## Services (`cloudflare.services.yml`)

| Service id | Class | Purpose |
|---|---|---|
| `cloudflare.api_client` | `CloudflareApiClient` | Talks to the Cloudflare API. Builds auth headers from `cloudflare.settings` (`auth_using` → Bearer token or X-Auth key/email). Methods include `validateAuthnKey($key, $email)` and zone listing. Inject as `@cloudflare.api_client`. |
| `cloudflare.state` | `State` (`CloudFlareStateInterface`) | Tracks API rate-limit and daily-tag-purge counters in Drupal State (keys `cloudflare_api_rate_count*`, `cloudflare_tag_purge_daily_*`). Used by the purger's diagnostic checks. |
| `logger.channel.cloudflare` | logger channel | The `cloudflare` log channel. |
| `http_middleware.cloudflare` | `CloudFlareMiddleware` | HTTP kernel middleware (priority **600**, before `ajax_page_state`) that restores the client IP. |

## The IP-restore middleware

`CloudFlareMiddleware::handle()` runs on every request:

1. Reads `HTTP_CF_CONNECTING_IP` (the real visitor) and `HTTP_CF_VISITOR` (scheme) from the
   request server bag.
2. If `bypass_host` matches the incoming host/URI, treats the request as a legitimate
   Cloudflare bypass (no warning).
3. When `client_ip_restore_enabled` is on, rewrites the request's client IP to
   `CF-Connecting-IP`. If `remote_addr_validate` is on, it first checks the connecting IP is in
   Cloudflare's published edge ranges (`getCloudFlareIpRanges()`), logging a warning on mismatch.

Config constants on the class: `CLOUDFLARE_CLIENT_IP_RESTORE_ENABLED`,
`CLOUDFLARE_REMOTE_ADDR_VALIDATE`, `CLOUDFLARE_BYPASS_HOST` (mirror the config keys).

## Using the API client

```php
/** @var \Drupal\cloudflare\CloudflareApiClientInterface $client */
$client = \Drupal::service('cloudflare.api_client');
$ok = $client->validateAuthnKey($key, $email);   // returns bool
```

Note: these make live Cloudflare API calls and require valid credentials + network; they are
not exercised in the evals (which are grounded in local config only).
