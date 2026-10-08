<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sucuri Cache purges the Sucuri CDN/WAF cache from Drupal.

---

Sucuri Cache enables integration with the cache API of Sucuri — a cloud security/CDN platform — so Drupal can purge Sucuri's cache when content changes, keeping the CDN-cached site fresh. It supports purging all cache or per-entity.

Sucuri API credentials should be stored securely (env-backed). Permissions cover full purge (`purge sucuri cache all`) and per-entity purge (`purge sucuri cache entity`). Supports Drupal 9, 10, and 11.

---

- Purge the Sucuri cache.
- Integrate the Sucuri cache API.
- Keep the CDN fresh.
- Purge on content change.
- Support full and per-entity purge.
- Store API credentials securely.
- Keep credentials env-backed.
- Gate full purge with `purge sucuri cache all`.
- Gate entity purge with `purge sucuri cache entity`.
- Support Drupal 9, 10, and 11.
- Integrate Sucuri CDN/WAF.
- Invalidate CDN cache.
- Configure the connection
- Manage cache purging
- Support security platform.
- Purge cache.
- Keep the key secure.
- Integrate Sucuri
