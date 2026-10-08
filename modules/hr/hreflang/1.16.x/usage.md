Hreflang adds `<link rel="alternate" hreflang="…" href="…">` tags to every page for each enabled language, telling search engines which URL to serve for each language or region.

---

Hreflang implements `hook_page_attachments()` to add one `rel="alternate"` hreflang link tag per available language to the head of every page, using the core language manager's language-switch links so each tag points at the equivalent URL in that language. Where Drupal core's Content Translation module adds hreflang tags only to translated entity pages, this module adds them site-wide (front page, views, custom routes, entity pages) as long as the site is multilingual. Absolute URLs are generated and the `url.query_args` cache context is added so query strings are preserved on the tags. Three boolean settings (config object `hreflang.settings`, schema provided) control behavior: `x_default` adds an extra `hreflang="x-default"` tag for the default language, `x_default_fallback` points that x-default tag at the configured fallback (selected) language instead of the site default, and `defer_to_content_translation` hands entity pages back to Content Translation (Hreflang then only adds the x-default tag) for better cache efficiency. Tags are skipped on 403/404 pages. A config event subscriber clears page caches (`http_response` tag) whenever the settings change so new settings take effect immediately. The settings form lives at Admin → Configuration → Search and metadata → Hreflang tags (`hreflang.admin_settings`, gated by `administer site configuration`). There is no module-specific API; the tags are altered with core hooks `hook_language_switch_links_alter()` or `hook_page_attachments_alter()`.

---

- Add hreflang rel-alternate tags to all pages of a multilingual site for SEO, not just translated entity pages.
- Tell Google which language/regional URL to serve in search results for each visitor.
- Emit one `hreflang="{langcode}"` tag per enabled language pointing at that language's URL.
- Add an `hreflang="x-default"` tag pointing at the site's default language for unmatched locales.
- Point the x-default tag at a configured fallback (selected) language instead of the site default.
- Cover non-entity pages (front page, views pages, custom routes) that Content Translation ignores.
- Add hreflang tags to the front page correctly using the `<front>` route.
- Preserve query-string parameters on hreflang tags via the `url.query_args` cache context.
- Defer to Content Translation on content entity pages while still adding your own x-default tag.
- Improve cache efficiency by deferring entity-page tags to Content Translation (avoids per-query-arg caches).
- Automatically skip hreflang tags on 403/404 error pages.
- Configure all behavior from a single settings form at `/admin/config/search/hreflang`.
- Deploy hreflang behavior between environments as configuration (`hreflang.settings` config object).
- Auto-clear page caches when hreflang settings change so tags update immediately.
- Restrict who can change hreflang settings via the `administer site configuration` permission.
- Alter the generated hreflang tags with `hook_language_switch_links_alter()` in a custom module.
- Remove or modify specific hreflang tags via `hook_page_attachments_alter()`.
- Generate absolute hreflang URLs so tags are valid for search-engine consumption.
- Support region-specific hreflang values (e.g. `en-us`, `fr-ca`) via configured language codes.
- Verify a site reports no hreflang tag errors in Google Search Console after installation.
- Use alongside Metatag by keeping metatag for other tags and letting Hreflang own rel-alternate hreflang tags.
- Only emit tags when the site is actually multilingual (single-language sites get none).
- Respect view access when adding the x-default tag in deferred (Content Translation) mode.
- Turn hreflang tagging on across an entire large site with a single module enable.
