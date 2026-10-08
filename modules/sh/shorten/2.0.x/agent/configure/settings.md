# Configure Shorten URLs

## Routes / permissions
| Route | Path | Permission |
|---|---|---|
| `shorten.admin_form` | `/admin/config/services/shorten` | `administer site configuration` |
| `shorten.keys_form` | `/admin/config/services/shorten/keys` | `manage Shorten URLs API keys` |
| `shorten.form_shorten_form_shorten_form_shorten` | `/shorten` | `use Shorten URLs page` |

Module-defined permissions (`shorten.permissions.yml`): `use Shorten URLs page`,
`manage Shorten URLs API keys` (neither is `restrict access: true`; the keys perm just gates
viewing/editing third-party API keys).

## General settings form (`ShortenAdminForm`, config `shorten.settings`)
- `shorten_method` — `php` (Guzzle) or `curl`; auto-defaults to whichever is available
  (`_shorten_method_default()`), cURL preferred.
- `shorten_service` — default/primary service machine key (e.g. `is.gd`, `TinyURL`, `bit.ly`).
- `shorten_service_backup` — used when the primary fails (must differ; j.mp==bit.ly is rejected).
- `shorten_show_service` — checkbox; if on, the block/page shows a service selector.
- `shorten_invisible_services` — serialized array of services hidden from the selector.
- `shorten_use_alias` — prefer the path-alias form of a URL when shortening.
- `shorten_www` — replace `http(s)://` with `www.` in output where shorter.
- `shorten_timeout` — request timeout (seconds, default 3).
- `shorten_cache_duration` — cache successful results (default 1814400 = 3 weeks; blank = permanent).
- `shorten_cache_fail_duration` — cache failures briefly (default 1800 = 30 min).
- `shorten_cache_clear_all` — whether to drop the shorten cache on a full cache clear.

## Keys form (`ShortenKeysForm`, same config object)
Text fields for third-party credentials: `shorten_bitly_login`, `shorten_bitly_key`,
`shorten_budurl`, `shorten_cligs`, `shorten_ez`, `shorten_fwd4me`, `shorten_googl`,
`shorten_redirec`. A service only appears in the selector once its key(s) are set (see
`hook_shorten_service` in [../hooks/hooks.md](../hooks/hooks.md)).

## Blocks
- `shorten` (admin_label "Shorten URLs") — embeds the `ShortenShortenForm` (paste + shorten).
- `shorten_short` (admin_label "Short URL") — embeds `ShortenFormCurrentPage`, showing the short
  URL for the page it is placed on (calls `shorten_url()` at build time). Place carefully: it
  triggers an outbound request on uncached pages.

## Drush / config
```
drush config:set shorten.settings shorten_service is.gd -y
drush config:set shorten.settings shorten_service_backup TinyURL -y
drush config:set shorten.settings shorten_timeout 3 -y
```
Schema: `config/schema/shorten.schema.yml`. Defaults: `config/install/shorten.settings.yml`.

## Note on request flow (not a redirect service)
Shortening is delegated to the external service: `shorten_fetch()` performs a server-side
GET to `https://<service-host>/…?url=<your-url>` (your URL as a query parameter to a **fixed**
service host) and returns the short URL the service replies with. The module has no local redirect
route and creates no local short codes, so there is no open-redirect surface in the main module.
