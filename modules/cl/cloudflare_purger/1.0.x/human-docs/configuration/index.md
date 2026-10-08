# Configuration

Cloudflare Purger has a small settings page of its own (Zone ID + token Key) and
is then wired into the **Purge** module's pipeline, plus a couple of container
parameters in your site's settings for hardening.

## Step 1 — Store the Cloudflare token in a Key

The purger reads its API token from a **Key** entity:

1. Go to **Configuration → System → Keys → Add key** and create a Key holding a
   Cloudflare API token.
2. Give the token only the **Purge** permission for the specific zone — the bare
   minimum, following least privilege. If your origin has fixed outbound IPs, also
   add them to the token's **Client IP Address Filtering** in Cloudflare, so a
   leaked token cannot be used from anywhere else.

> **Keep the token out of version control.** The environment‑variable or file key
> provider is recommended. With DDEV you can store it as an environment variable —
> `ddev dotenv set .ddev/.env --cloudflare-token=<value>` then `ddev restart` — and
> point the Key's provider at it.

## Step 2 — Enter the Zone ID and token on the settings page

Go to **Configuration → Web services → Cloudflare Purger**
(`/admin/config/services/cloudflare-purger`) and set:

- **Zone ID** — the 32‑character hexadecimal ID of your Cloudflare zone.
- **API token key** — select the **Key** you created in Step 1.

A validation constraint requires the Zone ID to be exactly 32 hex characters and
the selected Key to exist, so a typo is caught on save.

## Step 3 — Add the purger in Purge

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
2. Under **Purgers**, add the **Cloudflare** purger.
3. Check the status/diagnostics — the *Cloudflare Purger Configuration* check goes
   green once the Zone ID and token Key are set.

With that in place, Drupal adds a hashed `Cache-Tag` header to cacheable
responses, and invalidating cache tags triggers a purge‑by‑tags request to
Cloudflare.

## Step 4 — Guard against oversized headers (recommended)

On pages with many cache tags the `Cache-Tag` header can grow large, and some
hosts cap header sizes. The module exposes a container parameter,
`cloudflare_purger.max_response_header_length`: if the header would exceed it, the
header is omitted and the response is marked uncacheable at Cloudflare (via the
`Cloudflare-CDN-Cache-Control` header) instead of sending a truncated, unusable
tag list. Set it in your `services.yml` to match your host's limit. For example,
Cloudflare allows 16 kB but Acquia only 8 kB, so:

```yaml
parameters:
  # 8192 - strlen("Cache-Tag: ") = 8181
  cloudflare_purger.max_response_header_length: 8181
```

## Step 5 — Separate environments that share a zone (if needed)

If dev, test and prod share one Cloudflare zone (and a common `hash_salt`), they
could otherwise purge each other's cache. Give each its own cache‑tag prefix via
the `cloudflare_purger_cache_tag_prefix` setting in `settings.php`, for example:

```php
if (isset($_ENV['AH_SITE_GROUP'], $_ENV['AH_SITE_ENVIRONMENT'])) {
  $settings['cloudflare_purger_cache_tag_prefix'] = $_ENV['AH_SITE_GROUP'] . '.' . $_ENV['AH_SITE_ENVIRONMENT'];
}
```

This keeps each environment's cache tags unique so purges stay isolated.
