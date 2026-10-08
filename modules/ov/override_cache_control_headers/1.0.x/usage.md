<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Override Cache Control Headers lets an administrator set the `Cache-Control` response header on chosen URL patterns, overriding what Drupal would otherwise send.

---

Install it with Composer (`composer require drupal/override_cache_control_headers`) and enable it (`drush en override_cache_control_headers`); it has no dependencies beyond Drupal core `^8 || ^9 || ^10 || ^11`. Configure it at **Configuration › Development › Override Cache Control Headers** (`/admin/config/development/override-cache-control-headers`), which requires the `administer override cache control headers` permission. In the first textarea you add one rule per line in the form `path|directives`, for example `/blog|public, max-age=3600` or `/sitemap.xml|must-revalidate, no-cache, private`; paths may use `*` wildcards and may include a query string for exact matching. A second textarea adds **temporary** rules that also carry an expiry in minutes (`path|directives|minutes`); those are stored in Drupal's State, are listed back with their expiry time, can be cleared with the **Delete All Entry** button, and are removed automatically on cron once they expire. The same timed override can be set from the command line with `drush occh:set-temp-headers "/path|directives|minutes"`. The directives accepted by the form validator are `must-revalidate`, `no-cache`, `no-store`, `public`, `private`, `proxy-revalidate`, `max-age` and `s-maxage`. Internally a `kernel.response` event subscriber matches the request URI against your rules and rewrites the `Cache-Control` header; a `hook_override_cache_control_headers` hook fires when rules are added so you can, for example, purge a Varnish or CDN cache. Note that Drupal core still governs the cacheability of dynamic pages, so an override chosen for a page core considers uncacheable may be re-adjusted by core.

---

- Cache a rarely-changing page in a CDN for longer with `public, max-age=…`.
- Stop a specific page being cached during a campaign with `no-store`.
- Send `no-cache, private` for a sitemap or feed URL.
- Add `must-revalidate` so intermediaries re-check before serving.
- Set `s-maxage` for shared caches without changing browser caching.
- Apply a rule to a whole section using a `/section/*` wildcard.
- Match a URL only when a given query string is present (`/search?category=blog|…`).
- Match a path regardless of its query string (omit the `?` in the rule).
- Override headers only for a fixed time window using the temporary textarea.
- Set a timed override from a deploy script with `drush occh:set-temp-headers`.
- Review the currently active timed overrides and their expiry on the settings form.
- Clear all timed overrides at once with the Delete All Entry button.
- Let cron automatically revert temporary overrides when they expire.
- Purge a reverse-proxy/CDN cache from `hook_override_cache_control_headers` when rules change.
- Restrict who may change cache headers via the `administer override cache control headers` permission.
- Keep per-URL caching exceptions in one place instead of scattered web-server config.
- Adjust `max-age` for a single URL without patching code.
- Fix an integration that misbehaves because of Drupal's default headers on a path.
