# Configure — ignore list, action, redirects

## Config object

`page_cache_query_ignore.settings` (schema type `config_object`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `query_parameters` | sequence of string | `{}` (empty) | Parameter names the module acts on. |
| `ignore_action` | string | `exclude` | `exclude` = drop the listed params from the cache key (keep everything else). `include` = keep *only* the listed params, drop all others. |
| `ignore_redirects` | boolean | `false` | When `true`, redirect responses are cached under core's original (unstripped) cache key, so modules that need the real query string to compute a redirect target still work. |

## Settings form

Route `page_cache_query_ignore.admin` → `/admin/config/development/performance/page_cache_query_ignore`
(a tab/child of core's *Performance* settings). Permission: `administer site configuration`.
Fields: **Query parameters** (textarea, one name per line, required), **Ignore action**
(radios: exclude / include), **Ignore redirects** (checkbox). Submit trims each line and
`array_filter`s empties before saving.

## Set it with drush (no UI)

```bash
# Exclude common tracking params from the cache key:
drush cset page_cache_query_ignore.settings ignore_action exclude -y
drush cset page_cache_query_ignore.settings query_parameters.0 gclid -y
drush cset page_cache_query_ignore.settings query_parameters.1 fbclid -y
drush cset page_cache_query_ignore.settings query_parameters.2 utm_source -y
drush cset page_cache_query_ignore.settings ignore_redirects 0 -y
```

`query_parameters` is a sequence: set indexed keys (`query_parameters.0`, `.1`, …) or write the
whole list with `drush php:eval` / a config import. Example resetting to a known list:

```php
\Drupal::configFactory()->getEditable('page_cache_query_ignore.settings')
  ->set('query_parameters', ['gclid', 'fbclid', 'utm_source'])
  ->set('ignore_action', 'exclude')
  ->set('ignore_redirects', FALSE)
  ->save();
```

## How the cache key is affected

`PageCacheIgnore::getCacheId()` parses the request URI, then:
- `exclude` → `UrlHelper::filterQueryParameters($query, $list)` removes the listed names.
- `include` → keeps only keys present in `$list`.
Remaining params are `ksort`ed and the URI rebuilt, so parameter *order* never creates variants
either. The change is transparent to editors — stored content and response bodies are untouched;
only the anonymous page-cache lookup/write key changes. Run `drush cr` (or wait for cache
expiry) after changing the list so stale variants are not served.
