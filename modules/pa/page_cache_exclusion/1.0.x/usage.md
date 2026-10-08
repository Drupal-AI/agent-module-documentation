Page Cache Exclusion lets you stop Drupal's anonymous Internal Page Cache from storing specific pages — by path, when query parameters are present, or for 4xx responses — without disabling page cache site-wide.

---

The module decorates core's `http_middleware.page_cache` service: a `ServiceProvider` swaps the class
for `PageCacheAlter`, a subclass of core `PageCache` that overrides only the `set()` method (the point
where a rendered response is written to the cache). Before caching, `set()` reads three values from
`page_cache_exclusion.settings` and skips the cache write when any match: (1) `client_error_caching` —
if true, 4xx (client-error) responses are never cached; (2) `page_list` — a newline list of paths (core
`PathMatcher` patterns, so `*` wildcards and `<front>` work) that are excluded entirely; (3)
`page_query_parameters_list` — paths that should not be cached whenever the request carries any query
parameters. Matching is done against both the internal path and its lowercased path alias. Because it
only skips the *write*, pages already cached still serve from cache until expiry; and it only affects
the anonymous page cache, not Dynamic Page Cache or render caching. Configuration is a single admin form
under Performance (`administer site configuration`), and paths in both textareas must start with `/`
(validated). There are no permissions, plugins, Drush commands, or services of its own.

---

- Keep a specific page (e.g. `/cart`, `/user`, a live dashboard) always fresh for anonymous users.
- Exclude a whole section by wildcard, e.g. `/product/*`.
- Stop caching the front page by listing `<front>`.
- Avoid caching pages when tracking/query parameters are present (e.g. `?utm_source=...`) to prevent cache pollution.
- Serve search-results pages uncached because they vary by `?query=`.
- Prevent 4xx (403/404) responses from being cached so newly fixed pages appear immediately.
- Bypass cache for a page that shows time-sensitive or personalized-by-JS content.
- Exclude a form-heavy path where a cached empty state would be wrong.
- Keep a promotional landing page live while it is being edited frequently.
- Reduce stale-content support tickets on a few volatile URLs without turning off page cache globally.
- Exclude a webhook/callback-style path served to anonymous clients.
- Apply exclusions by path alias as well as the internal system path.
- Combine query-parameter exclusion with path exclusion for fine-grained control.
- Temporarily exclude a page during a campaign, then remove the rule to re-enable caching.
- Keep an A/B-tested URL variant uncached when the variant is chosen by query string.
- Avoid caching paginated listing pages that use `?page=` if freshness matters more than speed.
- Prevent caching of a status/health page meant to always reflect live state.
- Exclude localized paths (matching works on both alias and internal path).
- Set exclusions via config import (`page_cache_exclusion.settings`) for repeatable deployments.
