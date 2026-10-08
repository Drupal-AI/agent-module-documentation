<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rebuild (re-request) a URL right after its cache is purged.

---

Purge Cache Warmer implements a cache warmer which rebuilds a URL after the cache is cleared — hooking into the Purge pipeline so that when a URL is invalidated, the module immediately re-requests it to repopulate the page cache/CDN, keeping the first post-purge visitor from paying the cold-cache cost. Depends on `purge` and `purge_queuer_url`; supports Drupal 11.

---

- Warm caches after a purge.
- Re-request invalidated URLs.
- Repopulate page cache / CDN.
- Avoid cold-cache latency.
- Hook into the Purge pipeline.
- Depend on `purge` and `purge_queuer_url`.
- Support Drupal 11.
- Configure warming.
- Aid performance.
- Handle cache warming.
- Rebuild URLs.
- Keep caches warm
- Support Drupal.
- Support Drupal.
- Support Drupal.
