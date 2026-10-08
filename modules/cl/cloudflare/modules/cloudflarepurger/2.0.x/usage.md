<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Purger is the submodule that actually clears the Cloudflare CDN cache from Drupal — by cache tag, by URL, or the entire zone — by plugging into the Purge module as a purger plugin.

---

It provides a Purge **purger plugin**, `@PurgePurger(id = "cloudflare", label = "Cloudflare", types = {"tag", "url", "everything"})` (`CloudFlarePurger`), so Drupal's Purge pipeline can invalidate Cloudflare's cache when content changes. Because Cloudflare's `Cache-Tag` header has a size limit and Drupal cache tags can be long/numerous, an event subscriber (`CloudFlareCacheTagHeaderGenerator`, the surrogate-key generator) rewrites Drupal's `X-Drupal-Cache-Tags` into a Cloudflare-friendly `Cache-Tag` response header, hashing tags and honoring a byte limit (parameter `cloudflarepurger.cache_tag_header_limit`, 255) and an operator-defined exclude-list. Its config `cloudflarepurger.settings` holds `cache_tag_excludelist` (a sequence of tag prefixes to omit from the header/purge). Three Purge **diagnostic checks** report readiness on the Purge status page: `cloudflare_creds` (are Cloudflare credentials valid), `cloudflare_api_rate_limit_check` (API rate usage, via `cloudflare.state`), and `cloudflare_daily_limit_check` (daily tag-purge count). Settings share the parent's admin area (form at `/admin/config/services/cloudflare/purger`, permission `administer cloudflare`, configure route `cloudflare.admin_settings_form`). It requires the base `cloudflare` module (for API auth/credentials) and the `purge` module (which drives when purges happen). Actual purges call the Cloudflare API — evals here stay grounded in local config/plugin state.

---

- Automatically purge Cloudflare's cache when Drupal invalidates cache tags.
- Purge specific URLs from the Cloudflare cache after content edits.
- Purge an entire Cloudflare zone ("everything") on demand.
- Emit a Cloudflare-compatible `Cache-Tag` response header for tag-based purging.
- Hash long Drupal cache tags to fit Cloudflare's header size limit.
- Exclude noisy cache-tag prefixes from the Cloudflare header via `cache_tag_excludelist`.
- Integrate Cloudflare into Drupal's Purge processing pipeline.
- Monitor Cloudflare credential validity from the Purge diagnostics page.
- Watch Cloudflare API rate-limit usage before purges fail.
- Track the daily tag-purge count against Cloudflare limits.
- Keep CDN content fresh without manual cache clears.
- Purge by tag so only affected pages are invalidated (surgical invalidation).
- Pair with purge_queuer_url to purge changed URLs automatically.
- Configure which tag prefixes should never trigger a Cloudflare purge.
- Provide the Purge module a working Cloudflare backend.
- Reduce origin load by relying on tag-accurate CDN invalidation.
- Diagnose why purges are not reaching Cloudflare via the readiness checks.
