# Configure http_cache_control

## Where the settings live

The module has **no `configure` route and no admin page of its own**. It implements
`hook_form_system_performance_settings_alter()` to add fields onto Drupal core's
**Performance** form:

- Path: `/admin/config/development/performance`
- Route: `system.performance_settings`
- Permission: core `administer site configuration` (the module defines none).

All values are saved to one config object: **`http_cache_control.settings`**.
The submit handler `http_cache_control_form_system_performance_settings_submit()` writes them.
Changes take effect on the next response (clear caches with `drush cr` if needed).

## Config keys (`http_cache_control.settings`)

| Key | Type | Default | Meaning / emitted directive |
|---|---|---|---|
| `cache.http.s_maxage` | int (secs) | `0` | `Cache-Control: s-maxage=N` (shared/proxy lifetime). 0 = don't set. |
| `cache.http.404_max_age` | int | `0` | `s-maxage` used instead when response is **404**. |
| `cache.http.302_max_age` | int | `0` | `s-maxage` used instead when response is **302**. |
| `cache.http.301_max_age` | int | `0` | `s-maxage` used instead when response is **301**. |
| `cache.http.stale_while_revalidate` | int | `0` | `Cache-Control: stale-while-revalidate=N`. |
| `cache.http.stale_if_error` | int | `0` | `Cache-Control: stale-if-error=N`. |
| `cache.http.mustrevalidate` | bool | `false` | adds `must-revalidate`. |
| `cache.http.nocache` | bool | `false` | adds `no-cache`. |
| `cache.http.nostore` | bool | `false` | adds `no-store`. |
| `cache.http.vary` | string | `''` | comma-separated request-header names appended to `Vary` (`Cookie` auto-added unless `omit_vary_cookie`). |
| `cache.surrogate.maxage` | int | `0` | `Surrogate-Control: max-age=N`. |
| `cache.surrogate.nostore` | bool | `false` | `Surrogate-Control: no-store`. |
| `cache.targeted.items` | sequence | *(unset)* | list of targeted `{prefix}-Cache-Control` headers (see below). |

The browser `max-age` is core's own `system.performance:cache.page.max_age` key — the module
only relabels its form field to "Browser cache maximum age"; it does **not** store a copy.

### `cache.targeted.items` entry shape

Each item emits one header named `{target}-Cache-Control` (e.g. `CDN-Cache-Control`,
`Akamai-Cache-Control`, `Cloudflare-CDN-Cache-Control`):

```yaml
- target: CDN            # prefix; token [A-Za-z0-9][A-Za-z0-9-]*, "-Cache-Control" stripped if included
  max_age: 3600          # int seconds; emits max-age=N when > 0
  no_cache: false        # emits no-cache
  must_revalidate: false
  no_store: false        # emits no-store
  no_transform: false
  proxy_revalidate: false
  visibility: 'public'   # '' | public | private
```

Header value is built in directive order: `visibility`, `no-cache`, `max-age=N`,
`must-revalidate`, `no-store`, `no-transform`, `proxy-revalidate`.

## Expert mode

The "Expert mode" checkbox on the form (client-side only, not persisted) turns the max-age
dropdowns into free numeric inputs so you can store any second value. Setting a non-preset
integer directly in config has the same effect — the form auto-switches to a number field when
the stored value isn't one of the preset options.

## Drush recipes

Read current config:

```bash
drush config:get http_cache_control.settings
```

Long proxy cache, short browser cache, background revalidation:

```bash
drush config:set http_cache_control.settings cache.http.s_maxage 86400 -y
drush config:set http_cache_control.settings cache.http.stale_while_revalidate 30 -y
drush config:set http_cache_control.settings cache.http.stale_if_error 600 -y
drush cr
```

Vary on a request header (Cookie is appended automatically):

```bash
drush config:set http_cache_control.settings cache.http.vary 'Accept-Language' -y
```

Add a targeted `CDN-Cache-Control: public, max-age=3600` header (nested keys need php:eval):

```bash
drush php:eval '\Drupal::configFactory()->getEditable("http_cache_control.settings")
  ->set("cache.targeted.items", [[
    "target"=>"CDN","max_age"=>3600,"no_cache"=>false,"must_revalidate"=>false,
    "no_store"=>false,"no_transform"=>false,"proxy_revalidate"=>false,"visibility"=>"public",
  ]])->save();'
drush cr
```

## Notes / gotchas

- Directives are only added to **cacheable** responses; an authenticated/dynamic page that is
  already `no-cache, private` is left alone (see `api/headers.md`).
- `s-maxage` is only set when it is `> 0`, differs from the response's own max-age, and no
  `s-maxage` directive is already present.
- Purge (`drupal/purge`) is the recommended companion: hold long proxy lifetimes here, let
  Purge invalidate the proxy on content change.
