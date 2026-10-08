Acquia Purge GeoIP adds `X-Geo-Country` to Drupal's `Vary` response header so cached pages can be varied by the visitor's country, working with Acquia Cloud's edge geolocation.

---

Acquia Purge GeoIP is a tiny submodule of Acquia Purge that does one thing: it registers an event subscriber (`SetVaryHeader`) on the kernel response event and sets the `Vary: X-Geo-Country` header on outgoing responses. `X-Geo-Country` is a header Acquia Cloud's edge/GeoIP layer populates with the visitor's country, so declaring it in `Vary` tells Varnish and downstream caches to store a separate cached copy per country. This lets a single URL serve country-specific content (localized banners, currency, legal notices, redirects) while still being fully cacheable at the edge. The module has no configuration, no admin UI, no permissions and no dependencies declared beyond being enabled alongside Acquia Purge on an Acquia Cloud environment. Enable it only when your site actually differentiates content by country, since varying the cache multiplies the number of cached variants and lowers the hit rate. It is enabled with `drush en acquia_purge_geoip`.

---

- Serve country-specific homepage content from one cacheable URL on Acquia Cloud.
- Vary cached pages by the visitor's country using Acquia's edge GeoIP data.
- Show a localized cookie/consent or legal banner per country while keeping edge caching.
- Display region-appropriate currency or pricing without disabling Varnish.
- Add `Vary: X-Geo-Country` to responses automatically via a response event subscriber.
- Let Varnish store a separate cached variant per country for the same path.
- Geo-target marketing messaging while retaining full-page cache performance.
- Comply with region-specific content rules (e.g. GDPR notices) on cached pages.
- Redirect or theme differently by country at the application layer, cached per country.
- Enable geo-varied caching with a single `drush en acquia_purge_geoip` and no config.
- Pair with Acquia Purge so geo-varied pages are still tag-invalidated correctly.
- Keep hreflang/country landing pages cacheable instead of marking them uncacheable.
- Vary promotional blocks by country without per-user (uncacheable) personalization.
- Provide country-based shipping or availability notices on product pages, cached per country.
- Support multi-country single-site setups where content differs only by visitor country.
- Avoid hand-writing a custom event subscriber just to add the `X-Geo-Country` Vary header.
- Turn on geo-variation only on the environments (Acquia Cloud) where the edge sets the header.
- Test country-specific caching behavior by inspecting the `Vary` header in responses.
- Decommission the feature cleanly by uninstalling the submodule, leaving Acquia Purge intact.
