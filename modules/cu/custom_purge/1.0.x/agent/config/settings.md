<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Purge — configuration (`custom_purge.settings`)

There is **no settings form**. Edit the YAML and import it (`drush cim`, or write it with
`drush cset`/config import). Schema: `config/schema/custom_purge.schema.yml`. Install default:
`config/install/custom_purge.settings.yml`.

## Install / enable

```
drush en custom_purge -y        # pulls in core page_cache
```
Then edit `custom_purge.settings`. The shipped default has profile `production`, a single
`drupal_page_cache` cache instance and one default `localhost` domain — replace it with your real
domains and caches.

## Top-level shape

```yaml
profile: production          # the ACTIVE profile for this environment
profiles:                    # map of profile name => profile settings
  production:
    max_url_per_request: 25  # cap on URLs the form/request may purge at once
    flood_interval: 24       # flood window in HOURS (converted to seconds in code)
    flood_limit: 100         # max URL entries an operator may purge per window
    cache_instances: [...]   # ordered list of cache instances (order = purge order)
    domains: [...]           # per-domain settings
```
Only the profile named by the top-level `profile` key is used. Switching environments = point
`profile` at a different entry (e.g. `staging`, `local`).

## `cache_instances` (config type `custom_purge.plugin.[cache_type]`)

Each entry is one purge target. Common keys (`custom_purge.plugin`):

- `cache_type` — the **PurgePlugin id**: `drupal_page_cache`, `varnish`, or `cloudflare`.
- `cache_name` — a unique instance name you choose (referenced by `assigned_cache_instances`).
- `allow_url_purge` (bool) — may this instance purge single URLs?
- `allow_purge_everything` (bool) — may this instance purge everything?
- `delay_complete_purge` (int seconds) — 0 = purge-everything runs immediately; >0 = deferred via
  the `custom_purge_everything` queue until `now + delay` (see `api/purger-and-commands.md`).

Type-specific keys:

- **`drupal_page_cache`** (`custom_purge.plugin.drupal_page_cache`): `cid_extensions` — list of
  suffixes appended to each URL to build the cache CIDs to delete (default
  `[':', ':html', ':json', ':xml', ':xhtml']`).
- **`varnish`** (`custom_purge.plugin.varnish`): `ip`, `port`, `verifyhost` (bool, default true =
  `CURLOPT_SSL_VERIFYHOST`), `verifypeer` (bool, default true = `CURLOPT_SSL_VERIFYPEER`);
  `single.http_method` (default `PURGE`) + `single.http_headers` (list of `Name: value`);
  `everything.http_method` (default `BAN`), `everything.http_headers`, `everything.url` (path or
  absolute URL requested for a full purge). The request is pinned to `ip:port` via
  `CURLOPT_RESOLVE` for the domain, so DNS is not changed.
- **`cloudflare`** (`custom_purge.plugin.cloudflare`): `use_cf_settings` (bool — reuse the
  contrib **Cloudflare** module's `cloudflare.settings`); otherwise `email`, `zone_id`, `apikey`
  supplied here. Sent as `X-Auth-Email` / `X-Auth-Key` to
  `https://api.cloudflare.com/client/v4/zones/<zone_id>/purge_cache`.

## `domains`

Ordered list; each entry:

- `is_default` (bool) — used when a purged URL's domain matches no explicit entry (first default
  wins).
- `default_protocol` — `http` or `https`; used when a URL omits/mismatches the protocol.
- `domain` — hostname without protocol (e.g. `www.example.com`).
- `assigned_cache_instances` — list of `cache_name`s to purge for this domain (order not
  significant here).

Domain matching (in `Purger::purgeUrls()`): domains are sorted longest-first; a URL is assigned to
the first domain it contains **and** whose `default_protocol` it starts with, else the first domain
it merely contains, else its `parse_url` host, else the default domain.

## Example (from README / install default, extended)

```yaml
profile: production
profiles:
  production:
    max_url_per_request: 25
    flood_interval: 24
    flood_limit: 100
    cache_instances:
      - { cache_type: drupal_page_cache, cache_name: internal_page_cache, allow_url_purge: true, allow_purge_everything: true, delay_complete_purge: 0, cid_extensions: [':', ':html', ':json', ':xml', ':xhtml'] }
      - { cache_type: varnish, cache_name: my_varnish, allow_url_purge: true, allow_purge_everything: true, delay_complete_purge: 1800, ip: 127.0.0.1, port: 443, verifyhost: false, verifypeer: false, single: { http_method: DELETE, http_headers: {} }, everything: { http_method: BAN, http_headers: {}, url: '/ban-url' } }
      - { cache_type: cloudflare, cache_name: my_cloudflare, allow_url_purge: true, allow_purge_everything: true, delay_complete_purge: 3600, use_cf_settings: false, email: mail@example.com, zone_id: '123456', apikey: 'REDACTED' }
    domains:
      - { is_default: true, default_protocol: https, domain: example.com, assigned_cache_instances: [internal_page_cache, my_varnish, my_cloudflare] }
```

## Permissions

`custom_purge.permissions.yml` declares `administer custom_purge settings` (no route consumes it
in this release — configuration is YAML-only) and `use custom_purge url purger` (gates the
URL-purge form route).
