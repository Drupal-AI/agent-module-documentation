HTTP Cache Control fine-tunes the `Cache-Control` (and related) response headers Drupal emits, so shared caches, CDNs and reverse proxies can hold pages far longer than browsers do. It adds directives such as `s-maxage`, `stale-while-revalidate`, `stale-if-error`, `must-revalidate`, `no-cache`, `no-store`, `Surrogate-Control` and targeted `CDN-Cache-Control` headers on top of core's single page-cache max-age.

---

The module bolts extra fields onto Drupal's core Performance settings form (`/admin/config/development/performance`) rather than adding its own admin page, and stores everything in one config object, `http_cache_control.settings`. A response-event subscriber (`CacheControlEventSubscriber`, priority -10 on `KernelEvents::RESPONSE`) reads that config and, for cacheable responses, layers directives onto the outgoing headers. Core's "page cache maximum age" is relabelled "Browser cache maximum age" and becomes the browser `max-age`, while a separate "Shared cache max age" drives `s-maxage` for proxies; distinct max-ages can be set for 404, 301 and 302 responses. Revalidation directives `stale-while-revalidate` and `stale-if-error` let a proxy keep serving expired content while it refreshes or when the origin errors. A `Surrogate-Control` section targets surrogate proxies, an "Expert mode" toggle unlocks arbitrary numeric max-age values, and a "Targeted Cache-Control" section emits RFC 9213 style vendor headers (`CDN-Cache-Control`, `Akamai-Cache-Control`, `Cloudflare-CDN-Cache-Control`, or a custom prefix) each with their own directives. A `Vary` field appends request header names (with `Cookie` added automatically unless `omit_vary_cookie` is set). The module declares no dependencies, permissions, services beyond the subscriber, plugins or Drush commands; it pairs well with Purge/Varnish where proxies hold long lifetimes and browsers hold short ones.

---

- Give shared caches (Varnish, Nginx, CDN) a long `s-maxage` while keeping browser `max-age` short.
- Set `s-maxage` independently of the browser cache lifetime for reverse-proxy setups.
- Cache 404 Not Found responses at the proxy for a chosen period to blunt flood traffic to missing URLs.
- Cache 301 Permanent Redirect responses at the edge for a long lifetime.
- Cache 302 Temporary Redirect responses at the proxy for a short lifetime.
- Emit `stale-while-revalidate` so a CDN serves stale content while fetching a fresh copy in the background.
- Emit `stale-if-error` so a CDN keeps serving cached pages when Drupal returns an error.
- Add `must-revalidate` to force caches to never serve stale objects.
- Add `no-cache` to require revalidation on every request.
- Add `no-store` to forbid caching entirely (not recommended, but available).
- Add a `Surrogate-Control: max-age=...` header aimed specifically at surrogate proxies (Edge Side Includes).
- Add `Surrogate-Control: no-store` to keep surrogate proxies from caching a response.
- Emit a `CDN-Cache-Control` header that CDNs honour without affecting browser caching.
- Emit vendor-specific `Akamai-Cache-Control` or `Cloudflare-CDN-Cache-Control` headers.
- Emit a custom `{prefix}-Cache-Control` header for any other edge provider.
- Set per-target directives (`public`/`private`, `max-age`, `no-cache`, `must-revalidate`, `no-store`, `no-transform`, `proxy-revalidate`) on each targeted header.
- Append request header names to `Vary` (e.g. `Accept-Language`) to vary cached responses per header.
- Automatically add `Cookie` to `Vary` unless `omit_vary_cookie` is set in settings.php.
- Use "Expert mode" to enter arbitrary numeric max-age seconds instead of the preset dropdown values.
- Keep a CDN edge cache warm for a year while browsers only cache for 5 minutes.
- Layer HTTP caching config on top of the Purge module so proxies hold long lifetimes and are invalidated on change.
- Manage all Cache-Control tuning as exportable config (`http_cache_control.settings`) for deployment across environments.
- Script cache-header policy changes with `drush config:set http_cache_control.settings ...` in CI/CD.
- Differentiate proxy vs browser freshness without writing a custom response event subscriber.
- Reduce origin load by letting edge caches serve stale-but-usable content during deploys or outages.
