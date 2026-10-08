<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Warm the render cache for configured blocks.

---

Block Warmer warms the render cache for the configured blocks — extending the Warmer module so specified blocks' render cache is pre-built (on cron/warm runs) rather than lazily on the first request, reducing first-hit latency for expensive blocks. Depends on `warmer`; supports Drupal 8 through 11.

---

- Warm blocks' render cache.
- Pre-build configured blocks.
- Reduce first-hit latency.
- Extend the Warmer module.
- Run on cron/warm.
- Depend on `warmer`.
- Support Drupal 8 through 11.
- Configure which blocks.
- Aid performance.
- Handle block warming.
- Preload blocks.
- Warm caches
- Support Drupal.
- Support Drupal.
- Support Drupal.
