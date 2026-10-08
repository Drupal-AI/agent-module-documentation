# Configure Page Cache Exclusion

Config object: `page_cache_exclusion.settings`. Form:
`\Drupal\page_cache_exclusion\Form\PageCacheExclusionConfigForm` at
`/admin/config/development/performance/page_cache_exclusion` (route `page_cache_exclusion.admin`,
permission `administer site configuration`).

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `page_list` | string (newline-separated) | Paths excluded from page cache entirely. Core `PathMatcher` patterns — `*` wildcard, `<front>`. Each non-empty line must start with `/` (form-validated). |
| `page_query_parameters_list` | string (newline-separated) | Paths that are not cached **only when the request has any query parameters**. Same pattern/`/`-prefix rules. |
| `client_error_caching` | bool | When TRUE, 4xx (client-error) responses are never cached (`$response->isClientError()`). |

Schema: `config/schema` (module reports config schema). No defaults ship in `config/install`;
unset lists behave as "no exclusions" and `client_error_caching` defaults to FALSE in the form.

## How the decision is made (`PageCacheAlter::set()`)

The class extends core `\Drupal\page_cache\StackMiddleware\PageCache` and overrides `set()`. Before the
parent would cache, it returns early (skips caching) when:

1. `client_error_caching` is on and the response is a 4xx.
2. `page_list` is set and the current path OR its lowercased alias matches `page_list`.
3. `page_query_parameters_list` matches the path/alias **and** `$request->query->all()` is non-empty.

Path used is `path.current` (alias resolved via `path_alias.manager`, trailing slash trimmed except for
`/`). It is wired in by `PageCacheExclusionServiceProvider::alter()`, which re-points
`http_middleware.page_cache` to `PageCacheAlter` and injects `config.factory`, `path_alias.manager`,
`path.matcher`, `path.current`.

## Example (config import)

```yaml
# page_cache_exclusion.settings.yml
page_list: "/cart\n/product/*"
page_query_parameters_list: "/search\n<front>"
client_error_caching: true
```

## Caveats

- Skips the cache **write** only — previously cached pages keep serving until they expire; use
  `drush cr` or a cache purge to clear existing entries.
- Affects only the anonymous Internal Page Cache. Dynamic Page Cache and render caching are unaffected;
  authenticated traffic already bypasses page cache.
