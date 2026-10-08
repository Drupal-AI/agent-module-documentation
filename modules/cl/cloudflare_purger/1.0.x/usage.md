<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Purger clears Cloudflare's edge cache through the Purge module.

---

Cloudflare Purger provides purge support for Cloudflare — a purger plugin for the Purge module that sends cache-invalidation requests to Cloudflare's API when content changes, so the CDN edge cache stays in sync with the site (invalidating URLs/tags at Cloudflare on node/entity updates).

The Cloudflare API token is stored via a Key entity (`key` dependency) — never hard-coded/committed. Depends on `key` and `purge`; supports Drupal 10 and 11.

---

- Provide Cloudflare purge support.
- Act as a Purge purger plugin.
- Invalidate Cloudflare edge cache.
- Keep the CDN in sync.
- Send invalidations on content change.
- Invalidate URLs/tags at Cloudflare.
- Store the API token via a Key entity.
- Never hard-code/commit the token.
- Depend on `key` and `purge`.
- Support Drupal 10 and 11.
- Integrate with Purge.
- Clear the edge cache.
- Purge Cloudflare
- Handle invalidation
- Support CDN caching.
- Sync content.
- Configure the purger.
- Keep secrets in a Key
