# Configure Fastly

Forms under `/admin/config/services/fastly` (permission `administer fastly`). Config object
`fastly.settings` (the module ships **no** `config/install`, so keys exist only once saved).

## Main settings (`fastly.settings`)

| Key | Meaning |
|---|---|
| `api_key` | Fastly API token. Overridden by env `FASTLY_API_TOKEN` when set. Needs `global:read` + `purge_all` scopes to save. |
| `service_id` | Fastly Service ID. Overridden by env `FASTLY_API_SERVICE`. |
| `site_id` | Prefix added to cache tags before hashing (multi-site on one service). Env `FASTLY_SITE_ID`; auto-generated random if empty. |
| `purge_method` | `instant` (default) or `soft` — see [Purge Options](#purge-options). |
| `purge_logging` | bool — log purge operations. |
| `cache_tag_hash_length` | Surrogate-Key hash length (keeps header < 16 KB). Env `FASTLY_CACHE_TAG_HASH_LENGTH`. |
| `cookie_cache_bypass` | Cookies that bypass the cache. |

Routes: `fastly.settings` (main), `fastly.settings.purge_options`, `fastly.settings.stale_content_options`,
`fastly.settings.image_optimizer`, `fastly.settings.webhook`, `fastly.edge_modules`.

```bash
drush cget fastly.settings
drush cset fastly.settings purge_method soft -y
```

## Purge Options

`purge_method`: `instant` (`FASTLY_INSTANT_PURGE`) purges immediately; `soft`
(`FASTLY_SOFT_PURGE`) marks content stale so it can be revalidated. Also here:
`cache_tag_hash_length`, `purge_logging`.

## Stale Content Options

| Key | Meaning |
|---|---|
| `stale_while_revalidate` / `stale_while_revalidate_value` | Serve stale content while revalidating, for N seconds. |
| `stale_if_error` / `stale_if_error_value` | Serve stale content if the origin errors, for N seconds. |

## Image Optimizer

`image_optimization` (enable), `webp` + `webp_quality`, `jpeg_quality`, `jpeg_type`, `optimize`,
`resize_filter`, `upscale`. Also exposes a field formatter — see
[../api/services.md](../api/services.md).

## Webhooks

`webhook_enabled`, `webhook_url`, `webhook_notifications` (which events to post).

## Edge Modules

The Edge Modules UI (route `fastly.edge_modules`) stores each module under its own config object
`fastly.edge_modules.<name>` (e.g. `cors_headers`, `countryblock`, `redirect_hosts`,
`url_rewrites`, `disable_cache`, `datadome_integration`, `netacea_integration`,
`blackfire_integration`, `other_cms_integration`, `increase_timeouts_long_jobs`,
`force_cache_miss_on_hard_reload_for_admins`). These upload VCL to Fastly when enabled.

## Credentials via environment (recommended)

Set `FASTLY_API_TOKEN`, `FASTLY_API_SERVICE`, `FASTLY_SITE_ID` in the environment; when present
they take precedence over the stored config and the fields are locked in the UI.
