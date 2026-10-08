# Configure the header overrides

## Where

- Route: `override_cache_control_headers.admin` → **`/admin/config/development/override-cache-control-headers`**
  (linked from *Configuration › Development*, under the core Performance settings tree —
  `system.performance_settings`).
- Access: permission `administer override cache control headers` (`restrict access: true`).
- Form: `Drupal\override_cache_control_headers\Form\OverrideCacheControlHeadersSettingsForm`
  (`getFormId()` = `override_cache_control_headers_configuration`), a `ConfigFormBase` editing
  `override_cache_control_headers.settings`.

## The two textareas

1. **`urls_header`** — permanent overrides. One entry per line, format `path|directives`:

   ```
   /sitemap.xml|must-revalidate, no-cache, private
   /blog|public, max-age=3600
   /search?category=blog|no-cache, private
   /example/*|must-revalidate, no-cache, private
   ```

   Saved verbatim into config key `urls_header` (`processUrlsHeader()` in the form). This is the only
   value written to the config object.

2. **`urls_header_temp`** — timed overrides. Format `path|directives|minutes`:

   ```
   /sitemap.xml|must-revalidate, no-cache, private|10
   /search?category=blog|no-cache, private|15
   ```

   On submit these are **not** stored in config; `submitForm()` calls
   `Utility::setTempHeadersInState()`, which appends `start_ts` and `expiry_ts` and writes the entry to
   `State` under `override_cache_control_headers.urls_headers` as
   `path|directives|minutes|start_ts|expiry_ts`. A read-only textarea below (`urls_header_tmp`) lists
   the currently active timed entries with their expiry time, and a **Delete All Entry** submit button
   (`deleteAllUrlsHeaderTemp` → `Utility::deleteAllTempurls()`) clears the whole State list.

## Path matching (what a line matches)

The event subscriber matches the **current request URI** (`Request::getRequestUri()`, i.e. path +
query string) against `path` with core `path.matcher`.`matchPath()`:

- `*` is a wildcard (`/example/*`, `/example/*/page`, `/example/page/*`).
- If the request has a query string **and** the configured `path` has no `?`, the query string is
  stripped before matching (so `/search` matches `/search?x=1`).
- If the configured `path` contains `?`, the full request URI including query string is matched, so
  `/search?category=blog` matches only that exact query.
- First matching line wins (`setHeaders()` returns after the first hit).

## Validation (`Utility::validateCacheControlStrings()` + `validateDuplicateUrls()`)

- Line shape is checked by regex: permanent lines must be `path|directives`; temp lines must be
  `path|directives|minutes` (minutes = digits). A malformed line yields
  *"This … format is invalid."*
- **Directive allowlist** — each comma-separated directive (before any `=`) must be one of:
  `must-revalidate`, `no-cache`, `no-store`, `public`, `private`, `proxy-revalidate`, `max-age`,
  `s-maxage`. Anything else → *"This … cache-control directive is invalid."* (Note: `immutable`,
  `stale-while-revalidate`, `stale-if-error` shown in the README are **not** accepted by the
  validator.)
- **Internal-URL check** — non-wildcard paths must resolve to a valid internal path
  (`path.validator`) or a known alias in any enabled language; a leading country-language prefix
  such as `/ch-fr` is stripped and retried (`stripLeadingCountryLanguagePrefix()`). Wildcard paths
  skip this check.
- **Duplicate check** — the same `path` may not appear twice across the two textareas or against
  already-stored temp entries; duplicates raise *"Duplicate URL found: …"*.

## Config / State summary

| What | Store | Key |
|---|---|---|
| Permanent overrides | Config `override_cache_control_headers.settings` | `urls_header` |
| Timed overrides (with expiry) | `State` | `override_cache_control_headers.urls_headers` |

Saving the form (or the Drush command) calls `Utility::invalidateCache()`
(`configFactory->reset()` + invalidate `config:override_cache_control_headers.settings`) so the new
rules take effect.
