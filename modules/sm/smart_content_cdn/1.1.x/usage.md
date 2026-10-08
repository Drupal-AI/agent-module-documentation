<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content CDN moves Smart Content personalization to the CDN edge (Pantheon Edge Integrations). It reads Pantheon geo/interest request headers to drive server-side decisions and sets `Vary: Audience` / `Vary: Interest` response headers when a page contains geo or interest decisions, so the CDN caches a distinct variant per audience segment.

Use it to serve personalized content from cache on Pantheon without a client-side AJAX round-trip for geo/interest segments.

---

Install (requires `smart_content`, `smart_content_block`, `js_cookie` and the Pantheon EI `HeaderData` library on a Pantheon environment). Configure at Administration > Configuration > System > Smart Content CDN (`smart_content_cdn.config`, permission `configure smart content cdn`, which is `restrict access: TRUE`), where you map interest fields.

A response event subscriber (`HeaderEventSubscriber`, priority -200) inspects the response's cache tags: if `smart_content_cdn.geo` is present it adds `Audience` to Vary, and `smart_content_cdn.interest` adds `Interest`. A cookie subscriber manages a `subscriberToken` cookie. Geo/interest values come from Pantheon-injected request headers.

---

- Personalize at the CDN edge on Pantheon.
- Read Pantheon EI geo and interest request headers.
- Set `Vary: Audience` for geo decisions.
- Set `Vary: Interest` for interest decisions.
- Cache a distinct edge variant per segment.
- Avoid a client-side AJAX round-trip for cached segments.
- Map content interest fields via configuration.
- Manage a subscriber token cookie.
- Toggle Vary-header behavior via config.
- Merge with Vary headers set by other subscribers.
- Restrict configuration with a restricted permission.
- Integrate with Smart Content decisions and blocks.
- Support Drupal 8 through 11.
- Depend on the js_cookie library.
- Use cache tags to detect geo/interest decisions on a page.
- Work alongside Pantheon Edge Integrations.
