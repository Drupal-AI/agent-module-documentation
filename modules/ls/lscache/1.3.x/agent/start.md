<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LSCache (lscache) — agent index

**Drupal-native LiteSpeed Cache integration: emits `X-LiteSpeed-Tag` + `X-LiteSpeed-Cache-Control` on cacheable responses so LSWS caches pages by Drupal cache tag, with Purge-based tag invalidation.**

- **Version:** 1.3.x (1.3.5)
- **Core:** ^10.3 || ^11
- **Configure:** `lscache.settings` — `/admin/config/development/performance/lscache` (permission `administer lscache`).
- **Routes:** `lscache.settings` (admin); `lscache.fragment` — `/lscache-fragment/{token}` (`_access: TRUE`, GET, `no_cache`), controller `LscacheFragmentController`.
- **Services/elements:** `lscache.response_subscriber`, `lscache.tag_header_builder`, `lscache.token_signer`; render element `#type => 'lscache_esi'`. Submodule `lscache_purger` (needs drupal/purge) with Drush `lscache:diag`, `lscache:list-tag-coverage`.

**Security (already reviewed — sound):** admin settings route is permission-gated. The public `/lscache-fragment/{token}` route is protected because tokens are HMAC-SHA256 signed on the site hash salt (`LscacheTokenSigner`) and callbacks must implement `TrustedCallbackInterface`; the purger's `verify => false` is loopback/origin-direct only. No re-investigation performed in this batch.

See [configure/lscache.md](configure/lscache.md) and [api/lscache.md](api/lscache.md).
