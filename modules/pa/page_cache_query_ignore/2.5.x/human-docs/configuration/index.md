# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Performance → Page Cache Query Ignore**,
   or navigate directly to
   `/admin/config/development/performance/page_cache_query_ignore`.

The form has three settings, all stored in the `page_cache_query_ignore.settings`
configuration object.

## Query parameters

A **text area** where you list the query parameter names to act on — **one name
per line**. These are just the parameter names, not values. For a typical tracking
cleanup you might list:

```
gclid
fbclid
msclkid
utm_source
utm_medium
utm_campaign
utm_term
utm_content
```

Blank lines are ignored, and each name is trimmed when you save.

## Ignore action

Two radio options that decide *how* the list above is applied:

- **Exclude** *(default)* — drop the listed parameters from the cache key, and
  keep everything else. Use this for tracking parameters: strip `gclid`, `utm_*`,
  etc., while leaving genuinely meaningful parameters (like `page` or `sort`)
  intact so they still vary the cache.
- **Include** — the opposite, an allowlist: keep *only* the listed parameters in
  the cache key and drop everything else. Use this on a page where you know
  exactly which few parameters change the content (e.g. `page`, `sort`) and want
  every other parameter ignored.

Whichever mode you pick, the remaining parameters are also sorted, so differing
parameter *order* never creates separate cache entries.

## Ignore redirects

A **checkbox**. Some modules compute a redirect target from the incoming query
string — if you strip that query string from the cache key, those redirects could
be cached incorrectly. When this option is on, redirect responses are cached under
Drupal's original, unstripped cache key, so redirect logic that relies on the real
query string keeps working while normal pages still benefit from the stripping.
Leave it off unless you have redirects that depend on query parameters.

## Save and clear caches

Click **Save configuration**. Because the change affects how cache keys are
computed, run `drush cr` (or wait for the cache to expire) afterward so that stale,
un‑collapsed variants already in the cache are not served.

## For developers

The parameter list can also be adjusted at runtime: other modules can implement
`hook_page_cache_query_ignore_parameters_alter()` to add or remove names, or
subscribe to the `PageCacheQueryIgnoreEvents::PARAMETERS` and `::QUERY` events (the
latter lets you normalize values inside bracket arrays such as `?f[0]=…`). See the
sibling [`agent/`](../agent/start.md) docs for details.
