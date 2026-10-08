# Configuration

All of Akamai's settings live in one config object, **`akamai.settings`**, edited at
**Configuration → Akamai → Configure** (`/admin/config/akamai/config`). The form
requires the **Administer Akamai** permission.

## Credentials — store secrets safely

Akamai's Fast Purge API needs a client token, client secret, and access token. There
are two mutually exclusive ways to provide them, chosen by the **Storage method**
setting:

- **`.edgerc` file** — set the **Edgerc path** to a standard Akamai EdgeGrid `.edgerc`
  file on the server (with `host`, `access_token`, `client_token`, and
  `client_secret`), and the **Edgerc section** to the section within it (default
  `default`).
- **Key module** (recommended) — when the **Key** module is enabled, choose a Key
  entity for each of the access token, client token, and client secret, plus set the
  **REST API URL** (the CCU API host, e.g. `https://xxxx.purge.akamaiapis.net/`).
  With this method the settings store the *Key entity IDs*, not the raw secrets.

> **Keep secrets out of plain config.** Do not paste API secrets into settings that
> get exported to code. Store the value in an environment variable and reference it
> from a Key entity using the env key provider (or reference a `.edgerc` file that is
> outside version control). This keeps credentials out of your config export and your
> repository.

## Core settings

| Setting | Default | What it does |
|---|---|---|
| **Version** | `v3` | The CCU client version. Only `v3` (Fast Purge / CCUv3) ships. |
| **Disabled** | off | The **killswitch** — turn it on to stop all calls to Akamai (useful during maintenance or debugging). |
| **Base path** | none | Your site's fully-qualified domain prefix (e.g. `http://www.example.com`). Akamai indexes full URLs, so this expands relative paths. |
| **Timeout** | `5` | API request timeout in seconds. Raise it on slow networks. |
| **Domain / network** | production | Which Akamai network to target: **production** or **staging**. Use staging to validate purge behaviour safely. |
| **Action (CCUv3)** | delete | The purge action: **delete** (evict the object from the edge) or **invalidate** (mark it stale so it revalidates on the next request). |
| **Log requests** | off | Log every request and response to the `akamai` logger channel for troubleshooting. |

## Cache-tag header

- **Edge-Cache-Tag header** — when on, Drupal emits an `Edge-Cache-Tag` response
  header exposing its cache tags to Akamai, which enables tag-based (surrogate-key)
  purging via the `akamai_tag` purger.
- **Blacklist** — a list of noisy cache-tag prefixes to strip from that header.
- **Purge URLs with hostname** — send the base path as the Fast Purge `hostname`
  request member, useful on multi-host setups.

## Edgescape geolocation (optional)

- **Edgescape support** — when on, Akamai's Edgescape geolocation headers are
  processed and exposed to Drupal through the `[akamai:edgescape:*]` token (for
  example `[akamai:edgescape:country_code]`).

## Automatic purging with Purge

Most sites let the **Purge** module drive invalidation. Enable `purge` and its UI,
then at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`) enable the Akamai purgers:

- **`akamai`** — purges by URL / full path.
- **`akamai_tag`** — purges by cache tag (pairs with the `Edge-Cache-Tag` header).

Purge's diagnostic checks will warn you when Akamai credentials are missing or the
purge queue grows too long.

## Manual purging

Without Purge, editors can clear specific URLs from the form at
`/admin/config/akamai/cache-clear` (needs the **Purge Akamai cache** permission), or
place the **Akamai Cache Clear** block to flush the page they are currently viewing.

## Changing settings with Drush

```bash
# Kill switch on:
drush config:set akamai.settings disabled 1 -y
# Target the staging network instead of production:
drush config:set akamai.settings domain.staging 1 -y
drush config:set akamai.settings domain.production 0 -y
# Emit the Edge-Cache-Tag header:
drush config:set akamai.settings edge_cache_tag_header 1 -y
# Read a value:
drush config:get akamai.settings domain
```

Purging always respects the killswitch (`disabled`), the chosen network (`domain`),
and the action (`action_v3`).
